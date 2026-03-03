/// Input validation functions for clinical data entry.
class Validators {
  Validators._();

  /// Age: 10–60 years (maternal age range).
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) return 'Age is required';
    final v = double.tryParse(value);
    if (v == null) return 'Enter a valid number';
    if (v < 10 || v > 60) return 'Age must be between 10 and 60';
    return null;
  }

  /// Systolic BP: 70–160 mmHg.
  static String? validateSystolicBP(String? value) {
    if (value == null || value.isEmpty) return 'Systolic BP is required';
    final v = double.tryParse(value);
    if (v == null) return 'Enter a valid number';
    if (v < 70 || v > 160) return 'Systolic BP must be between 70 and 160 mmHg';
    return null;
  }

  /// Diastolic BP: 40–110 mmHg.
  static String? validateDiastolicBP(String? value) {
    if (value == null || value.isEmpty) return 'Diastolic BP is required';
    final v = double.tryParse(value);
    if (v == null) return 'Enter a valid number';
    if (v < 40 || v > 110) return 'Diastolic BP must be between 40 and 110 mmHg';
    return null;
  }

  /// Blood sugar: 6–19 mmol/L.
  static String? validateBloodSugar(String? value) {
    if (value == null || value.isEmpty) return 'Blood sugar is required';
    final v = double.tryParse(value);
    if (v == null) return 'Enter a valid number';
    if (v < 6 || v > 19) return 'Blood sugar must be between 6 and 19 mmol/L';
    return null;
  }

  /// Body temperature: 95–103 °F.
  static String? validateBodyTemp(String? value) {
    if (value == null || value.isEmpty) return 'Body temperature is required';
    final v = double.tryParse(value);
    if (v == null) return 'Enter a valid number';
    if (v < 95 || v > 103) return 'Body temp must be between 95 and 103 °F';
    return null;
  }

  /// Heart rate: 7–90 bpm.
  static String? validateHeartRate(String? value) {
    if (value == null || value.isEmpty) return 'Heart rate is required';
    final v = double.tryParse(value);
    if (v == null) return 'Enter a valid number';
    if (v < 7 || v > 90) return 'Heart rate must be between 7 and 90 bpm';
    return null;
  }

  /// Weight: 30–130 kg (optional field).
  static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) return null;
    final v = double.tryParse(value);
    if (v == null) return 'Enter a valid number';
    if (v < 30 || v > 130) return 'Weight must be between 30 and 130 kg';
    return null;
  }

  /// Height: 1.30–1.90 m (optional field).
  static String? validateHeight(String? value) {
    if (value == null || value.isEmpty) return null;
    final v = double.tryParse(value);
    if (v == null) return 'Enter a valid number';
    if (v < 1.30 || v > 1.90) return 'Height must be between 1.30 and 1.90 m';
    return null;
  }
}
