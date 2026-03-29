import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_model.freezed.dart';
part 'doctor_model.g.dart';

@freezed
abstract class DoctorModel with _$DoctorModel {
  const factory DoctorModel({
    @Default('') String uid,
    required String name,
    required String email,
    required String role,
    required String medicalId,
    @Default('pending') String status,
    @Default('') String avatarUrl,
    required DateTime createdAt,
  }) = _DoctorModel;

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  factory DoctorModel.fromFirestore(Map<String, dynamic> json, String uid) =>
      DoctorModel.fromJson(json).copyWith(uid: uid);
}
