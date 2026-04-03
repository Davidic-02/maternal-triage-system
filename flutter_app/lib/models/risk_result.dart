import 'package:freezed_annotation/freezed_annotation.dart';

part 'risk_result.freezed.dart';
part 'risk_result.g.dart';

@freezed
abstract class RiskResult with _$RiskResult {
  const RiskResult._();

  const factory RiskResult({
    required int riskClass,
    required List<double> probabilities,
    @Default([]) List<ShapFeature> shapFeatures,
  }) = _RiskResult;

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
}

@freezed
abstract class ShapFeature with _$ShapFeature {
  const ShapFeature._();

  const factory ShapFeature({
    required String featureName,
    required double shapValue,
  }) = _ShapFeature;

  bool get isPositive => shapValue >= 0;

  factory ShapFeature.fromJson(Map<String, dynamic> json) =>
      _$ShapFeatureFromJson(json);
}
