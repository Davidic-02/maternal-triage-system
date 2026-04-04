part of 'assessment_form_bloc.dart';

@freezed
abstract class AssessmentFormState with _$AssessmentFormState {
  const AssessmentFormState._();

  const factory AssessmentFormState({
    // ── section 1 — basic identification ──────────────────────
    @Default('') String patientNameOrId,
    @Default(NumericFieldFormz.pure()) NumericFieldFormz age,
    @Default('') String gestationalAge, // optional — not ML feature

    // ── section 2 — vital signs ────────────────────────────────
    @Default(NumericFieldFormz.pure()) NumericFieldFormz systolicBP,
    @Default(NumericFieldFormz.pure()) NumericFieldFormz diastolicBP,
    @Default(NumericFieldFormz.pure()) NumericFieldFormz heartRate,
    @Default('') String fetalHeartRate, // optional — not ML feature
    @Default(NumericFieldFormz.pure()) NumericFieldFormz bloodSugar,
    @Default(NumericFieldFormz.pure()) NumericFieldFormz bodyTemp,
    @Default('') String weight, // optional
    @Default('') String height, // optional

    // ── section 3 — danger signs ───────────────────────────────
    @Default(false) bool blurredVision,
    @Default(false) bool vaginalBleeding,
    @Default(false) bool severeSwelling,
    @Default(false) bool reducedFetalMovement,

    // ── section 4 — medical history ────────────────────────────
    @Default(false) bool previousComplications,
    @Default(false) bool preexistingDiabetes,
    @Default(false) bool gestationalDiabetes,
    @Default(false) bool hypertension,
    @Default('none') String mentalHealthStatus,

    // ── submission ─────────────────────────────────────────────
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    String? errorMessage,
  }) = _AssessmentFormState;

  // form valid only when all required fields pass
  bool get isFormValid =>
      age.isValid &&
      systolicBP.isValid &&
      diastolicBP.isValid &&
      heartRate.isValid &&
      bloodSugar.isValid &&
      bodyTemp.isValid;

  // derived — shown in UI for doctor reference
  double? get bmi {
    final w = double.tryParse(weight);
    final h = double.tryParse(height);
    if (w == null || h == null || h <= 0) return null;
    final heightM = h / 100; // cm → meters
    return w / (heightM * heightM);
  }

  double? get pulsePressure {
    final s = double.tryParse(systolicBP.value);
    final d = double.tryParse(diastolicBP.value);
    if (s == null || d == null) return null;
    return s - d;
  }

  // builds PatientRecord from form state — passed to AssessmentBloc
  PatientRecord toPatientRecord() => PatientRecord(
        patientNameOrId:
            patientNameOrId.isEmpty ? null : patientNameOrId,
        gestationalAge: gestationalAge.isEmpty
            ? null
            : double.tryParse(gestationalAge),
        fetalHeartRate: fetalHeartRate.isEmpty
            ? null
            : double.tryParse(fetalHeartRate),
        age: double.parse(age.value),
        systolicBP: double.parse(systolicBP.value),
        diastolicBP: double.parse(diastolicBP.value),
        heartRate: double.parse(heartRate.value),
        bloodSugar: double.parse(bloodSugar.value),
        bodyTemp: double.parse(bodyTemp.value),
        weight: weight.isEmpty ? null : double.tryParse(weight),
        height: height.isEmpty ? null : double.tryParse(height),
        previousComplications: previousComplications,
        preexistingDiabetes: preexistingDiabetes,
        gestationalDiabetes: gestationalDiabetes,
        hypertension: hypertension,
        blurredVision: blurredVision,
        vaginalBleeding: vaginalBleeding,
        severeSwelling: severeSwelling,
        reducedFetalMovement: reducedFetalMovement,
        mentalHealthStatus: mentalHealthStatus,
        createdAt: DateTime.now(),
      );
}

// ── validator for all required numeric fields ─────────────────

class NumericFieldFormz extends FormzInput<String, ValidationError> {
  const NumericFieldFormz.pure([super.value = '']) : super.pure();
  const NumericFieldFormz.dirty([super.value = '']) : super.dirty();

  @override
  ValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty;
    final parsed = double.tryParse(value);
    if (parsed == null) return ValidationError.invalid;
    if (parsed <= 0) return ValidationError.invalid;
    return null;
  }
}