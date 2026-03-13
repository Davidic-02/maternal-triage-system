import 'package:json_annotation/json_annotation.dart';

part 'risk_result.g.dart';

@JsonSerializable()
class RiskResult {
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

  String get recommendation {
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

  factory RiskResult.fromJson(Map<String, dynamic> json) =>
      _$RiskResultFromJson(json);

  Map<String, dynamic> toJson() => _$RiskResultToJson(this);
}

@JsonSerializable()
class ShapFeature {
  final String featureName;
  final double shapValue;

  const ShapFeature({
    required this.featureName,
    required this.shapValue,
  });

  bool get isPositive => shapValue >= 0;

  factory ShapFeature.fromJson(Map<String, dynamic> json) =>
      _$ShapFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$ShapFeatureToJson(this);
}
