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
import 'package:maternal_triage/services/offline_explanation.dart';
import 'package:maternal_triage/services/shap_service.dart';
import 'package:maternal_triage/utils/constants.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';
part 'assessment_bloc.freezed.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final InferenceService _inferenceService;
  final ShapService _shapService;
  final FirebaseService _firebaseService;
  final AuthBloc _authBloc;
  final GeminiService? _geminiService;

  AssessmentBloc({
    required AuthBloc authBloc,
    GeminiService? geminiService,
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
    await _shapService.loadBackground();
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

      // Save without awaiting: Firestore only completes a write once the
      // server acknowledges it, which would block the result screen offline.
      // With persistence enabled the record is queued locally and synced later.
      unawaited(
        _firebaseService.saveRecord(recordWithRisk).then<void>(
          (_) {},
          onError: (Object e) => print('Record saved locally; sync pending: $e'),
        ),
      );

      List<ShapFeature> shapFeatures = [];
      if (_shapService.isLoaded) {
        shapFeatures = _shapService.explainPatient(
          input: _inferenceService.buildInputTensor(auditedRecord),
          model: _inferenceService.predictHighRiskBatch,
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
    final threshold = _inferenceService.decisionThreshold;
    final offline = buildOfflineExplanation(record, result, threshold: threshold);
    final pHigh = result.probabilities.length == 2 ? result.probabilities[1] : null;
    final advisory = measurementAdvisory(record, pHigh, threshold);
    final gemini = _geminiService;
    if (!kAllowOnlineExplanations || gemini == null) {
      add(AssessmentEvent.explanationGenerated(offline));
      return;
    }
    try {
      final explanation = await gemini.generateClinicalExplanation(
        record: record,
        result: result,
      );
      add(AssessmentEvent.explanationGenerated(
        advisory == null ? explanation : '$explanation\n\n$advisory',
      ));
    } catch (e) {
      print('Online explanation failed, using offline explanation: $e');
      add(AssessmentEvent.explanationGenerated(offline));
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
