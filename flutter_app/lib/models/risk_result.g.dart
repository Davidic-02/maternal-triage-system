// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskResult _$RiskResultFromJson(Map<String, dynamic> json) => RiskResult(
      riskClass: (json['riskClass'] as num).toInt(),
      probabilities: (json['probabilities'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      shapFeatures: (json['shapFeatures'] as List<dynamic>)
          .map((e) => ShapFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RiskResultToJson(RiskResult instance) =>
    <String, dynamic>{
      'riskClass': instance.riskClass,
      'probabilities': instance.probabilities,
      'shapFeatures': instance.shapFeatures,
    };

ShapFeature _$ShapFeatureFromJson(Map<String, dynamic> json) => ShapFeature(
      featureName: json['featureName'] as String,
      shapValue: (json['shapValue'] as num).toDouble(),
    );

Map<String, dynamic> _$ShapFeatureToJson(ShapFeature instance) =>
    <String, dynamic>{
      'featureName': instance.featureName,
      'shapValue': instance.shapValue,
    };
