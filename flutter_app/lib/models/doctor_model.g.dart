// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => _DoctorModel(
  uid: json['uid'] as String? ?? '',
  name: json['name'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  medicalId: json['medicalId'] as String,
  status: json['status'] as String? ?? 'pending',
  avatarUrl: json['avatarUrl'] as String? ?? '',
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$DoctorModelToJson(_DoctorModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'medicalId': instance.medicalId,
      'status': instance.status,
      'avatarUrl': instance.avatarUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
