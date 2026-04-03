// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatientRecord _$PatientRecordFromJson(Map<String, dynamic> json) =>
    _PatientRecord(
      id: json['id'] as String?,
      age: (json['age'] as num).toDouble(),
      systolicBP: (json['systolicBP'] as num).toDouble(),
      diastolicBP: (json['diastolicBP'] as num).toDouble(),
      bloodSugar: (json['bloodSugar'] as num).toDouble(),
      bodyTemp: (json['bodyTemp'] as num).toDouble(),
      heartRate: (json['heartRate'] as num).toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      riskClass: (json['riskClass'] as num?)?.toInt() ?? 0,
      previousComplications: json['previousComplications'] as bool? ?? false,
      preexistingDiabetes: json['preexistingDiabetes'] as bool? ?? false,
      gestationalDiabetes: json['gestationalDiabetes'] as bool? ?? false,
      mentalHealthStatus: json['mentalHealthStatus'] as String? ?? 'none',
      resolved: json['resolved'] as bool? ?? false,
      resolvedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
        json['resolvedAt'],
        const TimestampConverter().fromJson,
      ),
      resolvedBy: json['resolvedBy'] as String?,
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      assessedBy: json['assessedBy'] as String?,
      hospitalId: json['hospitalId'] as String?,
    );

Map<String, dynamic> _$PatientRecordToJson(_PatientRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'age': instance.age,
      'systolicBP': instance.systolicBP,
      'diastolicBP': instance.diastolicBP,
      'bloodSugar': instance.bloodSugar,
      'bodyTemp': instance.bodyTemp,
      'heartRate': instance.heartRate,
      'weight': instance.weight,
      'height': instance.height,
      'riskClass': instance.riskClass,
      'previousComplications': instance.previousComplications,
      'preexistingDiabetes': instance.preexistingDiabetes,
      'gestationalDiabetes': instance.gestationalDiabetes,
      'mentalHealthStatus': instance.mentalHealthStatus,
      'resolved': instance.resolved,
      'resolvedAt': _$JsonConverterToJson<Timestamp, DateTime>(
        instance.resolvedAt,
        const TimestampConverter().toJson,
      ),
      'resolvedBy': instance.resolvedBy,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'assessedBy': instance.assessedBy,
      'hospitalId': instance.hospitalId,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
