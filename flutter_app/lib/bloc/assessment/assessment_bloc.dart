import 'dart:async';
import 'package:formz/formz.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/models/risk_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maternal_triage/services/firebase_patient_service.dart';
import 'package:maternal_triage/services/gemini_service.dart';
import 'package:maternal_triage/services/inference_service.dart';
import 'package:maternal_triage/services/shap_service.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';
part 'assessment_bloc.freezed.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final InferenceService _inferenceService;
  final ShapService _shapService;
  final FirebaseService _firebaseService;
  final AuthBloc _authBloc;
  final GeminiService _geminiService;

  AssessmentBloc({
    required AuthBloc authBloc,
    required GeminiService geminiService,
    InferenceService? inferenceService,
    ShapService? shapService,
    FirebaseService? firebaseService,
  }) : _authBloc = authBloc,
       _inferenceService = inferenceService ?? InferenceService(),
       _shapService = shapService ?? ShapService(),
       _firebaseService = firebaseService ?? FirebaseService(),
       _geminiService = geminiService,
       super(const AssessmentState()) {
    on<_RunAssessment>(_onRunAssessment);
    on<_ClearAssessment>(_onClearAssessment);
    on<_ExplanationGenerated>(_onExplanationGenerated);
    on<_ExplanationFailed>(_onExplanationFailed);
  }

  Future<void> initialise() async {
    await _inferenceService.loadModel();
    await _shapService.loadShapValues();
  }

  Future<void> _onRunAssessment(
    _RunAssessment event,
    Emitter<AssessmentState> emit,
  ) async {
    if (state.status == FormzSubmissionStatus.inProgress) return;

    if (!event.patientRecord.isValid) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: "Patient Record is invalid",
        ),
      );
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final auditedRecord = event.patientRecord.copyWith(
        assessedBy: _authBloc.state.userEmail,
        createdAt: DateTime.now(),
      );

      final inferenceResult = _inferenceService.predict(auditedRecord);
      final riskClass = inferenceResult['riskClass'] as int;
      final probs = inferenceResult['probabilities'] as List<double>;

      // ✅ Create with risk once
      final recordWithRisk = auditedRecord.copyWith(riskClass: riskClass);

      // ✅ Save once
      await _firebaseService.saveRecord(recordWithRisk);

      List<ShapFeature> shapFeatures = [];
      if (_shapService.isLoaded) {
        shapFeatures = _shapService.getLocalExplanation(
          index: 0,
          predictedClass: riskClass,
        );
      }

      final riskResult = RiskResult(
        riskClass: riskClass,
        probabilities: probs,
        shapFeatures: shapFeatures,
      );

      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          result: riskResult,
          record: recordWithRisk,
          isGeneratingExplanation: true,
          errorMessage: null,
        ),
      );
      _generateExplanation(recordWithRisk, riskResult);
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _generateExplanation(
    PatientRecord record,
    RiskResult result,
  ) async {
    try {
      final explanation = await _geminiService.generateClinicalExplanation(
        record: record,
        result: result,
      );
      add(AssessmentEvent.explanationGenerated(explanation));
    } catch (e) {
      print('Error generating explanation: $e');
      add(const AssessmentEvent.explanationFailed());
    }
  }

  void _onExplanationGenerated(
    _ExplanationGenerated event,
    Emitter<AssessmentState> emit,
  ) {
    emit(
      state.copyWith(
        clinicalExplanation: event.explanation,
        isGeneratingExplanation: false,
      ),
    );
  }

  void _onExplanationFailed(
    _ExplanationFailed event,
    Emitter<AssessmentState> emit,
  ) {
    emit(state.copyWith(isGeneratingExplanation: false));
  }

  void _onClearAssessment(
    _ClearAssessment event,
    Emitter<AssessmentState> emit,
  ) {
    emit(const AssessmentState());
  }

  @override
  Future<void> close() {
    _inferenceService.dispose();
    return super.close();
  }
}
