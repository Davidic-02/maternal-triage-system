import 'dart:async';
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

    Future<void> initialise() async {
      await _inferenceService.loadModel();
      await _shapService.loadShapValues();
    }
  }
}
