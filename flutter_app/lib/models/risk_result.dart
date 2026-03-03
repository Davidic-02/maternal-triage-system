/// Data model for a triage prediction result, including SHAP explanations.
class RiskResult {
  /// 0 = low, 1 = mid, 2 = high
  final int riskClass;
  final List<double> probabilities;
  final List<ShapFeature> shapFeatures;

  const RiskResult({
    required this.riskClass,
    required this.probabilities,
    required this.shapFeatures,
  });

  String get riskLabel {
    switch (riskClass) {
      case 0:
        return 'Low';
      case 1:
        return 'Mid';
      case 2:
        return 'High';
      default:
        return 'Unknown';
    }
  }

  String get recommendedAction {
    switch (riskClass) {
      case 0:
        return 'Routine monitoring. Schedule standard antenatal follow-up.';
      case 1:
        return 'Increased monitoring required. Refer to specialist within 48 hours.';
      case 2:
        return 'Immediate intervention needed. Transfer to tertiary facility now.';
      default:
        return 'Consult a healthcare provider.';
    }
  }
}

/// A single SHAP feature contribution.
class ShapFeature {
  final String featureName;
  final double shapValue;

  const ShapFeature({required this.featureName, required this.shapValue});

  bool get isPositive => shapValue >= 0;
}
