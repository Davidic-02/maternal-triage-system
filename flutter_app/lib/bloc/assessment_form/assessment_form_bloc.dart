import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:maternal_triage/bloc/assessment/assessment_bloc.dart';
import 'package:maternal_triage/enums/validator_error.dart';
import 'package:maternal_triage/models/patient_record.dart';
import '../../services/logging_helper.dart';

part 'assessment_form_event.dart';
part 'assessment_form_state.dart';
part 'assessment_form_bloc.freezed.dart';

class AssessmentFormBloc
    extends Bloc<AssessmentFormEvent, AssessmentFormState> {
  final AssessmentBloc _assessmentBloc;
  AssessmentFormBloc({required AssessmentBloc assessmentBloc})
    : _assessmentBloc = assessmentBloc,
      super(const AssessmentFormState()) {
    // ── section 1 ────────────────────────────────────────────
    on<_PatientNameOrIdChanged>(_onPatientNameOrIdChanged);
    on<_AgeChanged>(_onAgeChanged);
    on<_GestationalAgeChanged>(_onGestationalAgeChanged);

    // ── section 2 ────────────────────────────────────────────
    on<_SystolicBPChanged>(_onSystolicBPChanged);
    on<_DiastolicBPChanged>(_onDiastolicBPChanged);
    on<_HeartRateChanged>(_onHeartRateChanged);
    on<_FetalHeartRateChanged>(_onFetalHeartRateChanged);
    on<_BloodSugarChanged>(_onBloodSugarChanged);
    on<_BodyTempChanged>(_onBodyTempChanged);
    on<_WeightChanged>(_onWeightChanged);
    on<_HeightChanged>(_onHeightChanged);

    // ── section 3 ────────────────────────────────────────────
    on<_BlurredVisionToggled>(_onBlurredVisionToggled);
    on<_VaginalBleedingToggled>(_onVaginalBleedingToggled);
    on<_SevereSwellingToggled>(_onSevereSwellingToggled);
    on<_ReducedFetalMovementToggled>(_onReducedFetalMovementToggled);

    // ── section 4 ────────────────────────────────────────────
    on<_PreviousComplicationsToggled>(_onPreviousComplicationsToggled);
    on<_PreexistingDiabetesToggled>(_onPreexistingDiabetesToggled);
    on<_GestationalDiabetesToggled>(_onGestationalDiabetesToggled);
    on<_HypertensionToggled>(_onHypertensionToggled);
    on<_MentalHealthStatusChanged>(_onMentalHealthStatusChanged);

    // ── actions ───────────────────────────────────────────────
    on<_Submitted>(_onSubmitted);
    on<_Cleared>(_onCleared);
  }

  void _onPatientNameOrIdChanged(
    _PatientNameOrIdChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    emit(state.copyWith(patientNameOrId: event.value));
  }

  void _onAgeChanged(_AgeChanged event, Emitter<AssessmentFormState> emit) {
    final age = NumericFieldFormz.dirty(event.value);
    emit(
      state.copyWith(
        age: age.isValid ? age : NumericFieldFormz.pure(event.value),
      ),
    );
  }

  void _onGestationalAgeChanged(
    _GestationalAgeChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    emit(state.copyWith(gestationalAge: event.value));
  }

  void _onSystolicBPChanged(
    _SystolicBPChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    final systolicBP = NumericFieldFormz.dirty(event.value);
    emit(
      state.copyWith(
        systolicBP: systolicBP.isValid
            ? systolicBP
            : NumericFieldFormz.pure(event.value),
      ),
    );
  }

  void _onDiastolicBPChanged(
    _DiastolicBPChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    final diastolicBP = NumericFieldFormz.dirty(event.value);
    emit(
      state.copyWith(
        diastolicBP: diastolicBP.isValid
            ? diastolicBP
            : NumericFieldFormz.pure(event.value),
      ),
    );
  }

  void _onHeartRateChanged(
    _HeartRateChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    final heartRate = NumericFieldFormz.dirty(event.value);
    emit(
      state.copyWith(
        heartRate: heartRate.isValid
            ? heartRate
            : NumericFieldFormz.pure(event.value),
      ),
    );
  }

  void _onFetalHeartRateChanged(
    _FetalHeartRateChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    emit(state.copyWith(fetalHeartRate: event.value));
  }

  void _onBloodSugarChanged(
    _BloodSugarChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    final bloodSugar = NumericFieldFormz.dirty(event.value);
    emit(
      state.copyWith(
        bloodSugar: bloodSugar.isValid
            ? bloodSugar
            : NumericFieldFormz.pure(event.value),
      ),
    );
  }

  void _onBodyTempChanged(
    _BodyTempChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    final bodyTemp = NumericFieldFormz.dirty(event.value);
    emit(
      state.copyWith(
        bodyTemp: bodyTemp.isValid
            ? bodyTemp
            : NumericFieldFormz.pure(event.value),
      ),
    );
  }

  void _onWeightChanged(
    _WeightChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    emit(state.copyWith(weight: event.value));
  }

  void _onHeightChanged(
    _HeightChanged event,
    Emitter<AssessmentFormState> emit,
  ) {
    emit(state.copyWith(height: event.value));
  }

  void _onBlurredVisionToggled(
    _BlurredVisionToggled event,
    Emitter<AssessmentFormState> emit,
  ) {
    emit(state.copyWith(blurredVision: !state.blurredVision));
  }

  void _onVaginalBleedingToggled(
    _VaginalBleedingToggled event,
    Emitter<AssessmentFormState> emit,
  ) {
    emit(state.copyWith(vaginalBleeding: !state.vaginalBleeding));
  }

  void _onSevereSwellingToggled(
    _SevereSwellingToggled event,
    Emitter<AssessmentFormState> emit,
  ) {
    emit(state.copyWith(severeSwelling: !state.severeSwelling));
  }

  void _onReducedFetalMovementToggled(
    _ReducedFetalMovementToggled event,
    Emitter<AssessmentFormState> emit,
  ) {
    emit(state.copyWith(reducedFetalMovement: !state.reducedFetalMovement));
  }
}
