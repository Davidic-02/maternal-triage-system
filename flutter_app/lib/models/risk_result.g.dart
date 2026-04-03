// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RiskResult _$RiskResultFromJson(Map<String, dynamic> json) => _RiskResult(
  riskClass: (json['riskClass'] as num).toInt(),
  probabilities: (json['probabilities'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  shapFeatures:
      (json['shapFeatures'] as List<dynamic>?)
          ?.map((e) => ShapFeature.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$RiskResultToJson(_RiskResult instance) =>
    <String, dynamic>{
      'riskClass': instance.riskClass,
      'probabilities': instance.probabilities,
      'shapFeatures': instance.shapFeatures,
    };

_ShapFeature _$ShapFeatureFromJson(Map<String, dynamic> json) => _ShapFeature(
  featureName: json['featureName'] as String,
  shapValue: (json['shapValue'] as num).toDouble(),
);

Map<String, dynamic> _$ShapFeatureToJson(_ShapFeature instance) =>
    <String, dynamic>{
      'featureName': instance.featureName,
      'shapValue': instance.shapValue,
    };
