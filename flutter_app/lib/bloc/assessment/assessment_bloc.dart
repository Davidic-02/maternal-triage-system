import 'dart:async';
import 'package:formz/formz.dart';
import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/models/risk_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maternal_triage/services/firebase_service.dart';
import 'package:maternal_triage/services/inference_service.dart';
import 'package:maternal_triage/services/shap_service.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';
part 'assessment_bloc.freezed.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final InferenceService _inferenceService;
  final ShapService _shapService;
  final FirebaseService _firebaseService;

  AssessmentBloc({
    InferenceService? inferenceService,
    ShapService? shapService,
    FirebaseService? firebaseService,
  })  : _inferenceService = inferenceService ?? InferenceService(),
        _shapService = shapService ?? ShapService(),
        _firebaseService = firebaseService ?? FirebaseService(),
        super(const AssessmentState()) {
    on<_RunAssessment>(_onRunAssessment);
    on<_ClearAssessment>(_onClearAssessment);
  }

  Future<void> initialise() async {
    await _inferenceService.loadModel();
    await _shapService.loadShapValues();
  }

  Future<void> _onRunAssessment(
      _RunAssessment event, Emitter<AssessmentState> emit) async {
    if (state.status == FormzSubmissionStatus.inProgress) return;

    if (!event.patientRecord.isValid) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: "Patient Record is invalid"));
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final inferenceResult = _inferenceService.predict(event.patientRecord);
      final riskClass = inferenceResult['riskClass'] as int;
      final probs = inferenceResult['probabilities'] as List<double>;

      List<ShapFeature> shapFeatures = [];
      if (_shapService.isLoaded) {
        shapFeatures = _shapService.getLocalExplanation(
            index: 0, predictedClass: riskClass);
      }

      final riskResult = RiskResult(
          riskClass: riskClass,
          probabilities: probs,
          shapFeatures: shapFeatures);
      await _firebaseService.saveRecord(event.patientRecord);
      emit(state.copyWith(
          status: FormzSubmissionStatus.success,
          result: riskResult,
          record: event.patientRecord,
          errorMessage: null));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
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
