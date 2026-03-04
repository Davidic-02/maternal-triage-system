/// Asset paths for the ONNX model, scaler params, and SHAP values.
const String kModelAsset = 'assets/models/maternal_triage_model.onnx';
const String kScalerAsset = 'assets/scaler/scaler_params.json';
const String kShapAsset = 'assets/shap/shap_values.json';

/// Normalisation constants (Min-Max) for the 14 input features.
///
/// Order must match the feature vector built in [InferenceService]:
/// Age, SystolicBP, DiastolicBP, BloodSugar, BodyTemp, BMI, HeartRate,
/// Weight, Height, PreviousComplications, PreexistingDiabetes,
/// GestationalDiabetes, MentalHealthStatus, PulsePressure.
///
/// These are fallback values — real values are loaded at runtime from
/// [kScalerAsset] (assets/scaler/scaler_params.json).
class FeatureNorm {
  static const List<double> min = [
    10.0,  // Age
    70.0,  // SystolicBP
    40.0,  // DiastolicBP
    6.0,   // BloodSugar
    95.0,  // BodyTemp (Fahrenheit)
    0.0,   // BMI
    40.0,  // HeartRate
    30.0,  // Weight (kg)
    1.30,  // Height (m)
    0.0,   // PreviousComplications
    0.0,   // PreexistingDiabetes
    0.0,   // GestationalDiabetes
    0.0,   // MentalHealthStatus
    10.0,  // PulsePressure
  ];

  static const List<double> max = [
    70.0,   // Age
    160.0,  // SystolicBP
    110.0,  // DiastolicBP
    19.0,   // BloodSugar
    103.0,  // BodyTemp (Fahrenheit)
    37.0,   // BMI
    120.0,  // HeartRate
    130.0,  // Weight (kg)
    1.90,   // Height (m)
    1.0,    // PreviousComplications
    1.0,    // PreexistingDiabetes
    1.0,    // GestationalDiabetes
    3.0,    // MentalHealthStatus
    80.0,   // PulsePressure
  ];
}

/// Risk level labels indexed by class (0=low, 1=mid, 2=high).
const List<String> kRiskLabels = ['Low', 'Mid', 'High'];

/// Mental health status options for the dropdown.
const List<String> kMentalHealthOptions = ['none', 'mild', 'moderate', 'severe'];
