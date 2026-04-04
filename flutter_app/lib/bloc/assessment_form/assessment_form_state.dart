

part of 'assessment_form_bloc.dart';

@freezed
abstract class AssessmentFormEvent with _$AssessmentFormEvent {
  // ── section 1 — basic identification ────────────────────────
  const factory AssessmentFormEvent.patientNameOrIdChanged(String value) =
      _PatientNameOrIdChanged;
  const factory AssessmentFormEvent.ageChanged(String value) = _AgeChanged;
  const factory AssessmentFormEvent.gestationalAgeChanged(String value) =
      _GestationalAgeChanged;

  // ── section 2 — vital signs ──────────────────────────────────
  const factory AssessmentFormEvent.systolicBPChanged(String value) =
      _SystolicBPChanged;
  const factory AssessmentFormEvent.diastolicBPChanged(String value) =
      _DiastolicBPChanged;
  const factory AssessmentFormEvent.heartRateChanged(String value) =
      _HeartRateChanged;
  const factory AssessmentFormEvent.fetalHeartRateChanged(String value) =
      _FetalHeartRateChanged;
  const factory AssessmentFormEvent.bloodSugarChanged(String value) =
      _BloodSugarChanged;
  const factory AssessmentFormEvent.bodyTempChanged(String value) =
      _BodyTempChanged;
  const factory AssessmentFormEvent.weightChanged(String value) =
      _WeightChanged;
  const factory AssessmentFormEvent.heightChanged(String value) =
      _HeightChanged;

  // ── section 3 — danger signs ─────────────────────────────────
  const factory AssessmentFormEvent.blurredVisionToggled() =
      _BlurredVisionToggled;
  const factory AssessmentFormEvent.vaginalBleedingToggled() =
      _VaginalBleedingToggled;
  const factory AssessmentFormEvent.severeSwellingToggled() =
      _SevereSwellingToggled;
  const factory AssessmentFormEvent.reducedFetalMovementToggled() =
      _ReducedFetalMovementToggled;

  // ── section 4 — medical history ──────────────────────────────
  const factory AssessmentFormEvent.previousComplicationsToggled() =
      _PreviousComplicationsToggled;
  const factory AssessmentFormEvent.preexistingDiabetesToggled() =
      _PreexistingDiabetesToggled;
  const factory AssessmentFormEvent.gestationalDiabetesToggled() =
      _GestationalDiabetesToggled;
  const factory AssessmentFormEvent.hypertensionToggled() =
      _HypertensionToggled;
  const factory AssessmentFormEvent.mentalHealthStatusChanged(String value) =
      _MentalHealthStatusChanged;

  // ── actions ──────────────────────────────────────────────────
  const factory AssessmentFormEvent.submitted() = _Submitted;
  const factory AssessmentFormEvent.cleared() = _Cleared;
}