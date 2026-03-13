import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_record.freezed.dart';
part 'patient_record.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
abstract class PatientRecord with _$PatientRecord {
  const PatientRecord._();
  const factory PatientRecord({
    String? id,
    required double age,
    required double systolicBP,
    required double diastolicBP,
    required double bloodSugar,
    required double bodyTemp,
    required double heartRate,
    double? weight,
    double? height,
    @Default(false) bool previousComplications,
    @Default(false) bool preexistingDiabetes,
    @Default(false) bool gestationalDiabetes,
    @Default('none') String mentalHealthStatus,
    @TimestampConverter() required DateTime createdAt,
  }) = _PatientRecord;
  bool get isValid {
    if (age <= 0) return false;
    if (systolicBP <= 0 || diastolicBP <= 0) return false;
    if (bloodSugar <= 0) return false;
    if (bodyTemp <= 0) return false;
    if (heartRate <= 0) return false;
    if (weight != null && weight! <= 0) return false;
    if (height != null && height! <= 0) return false;
    return true;
  }

  factory PatientRecord.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordFromJson(json);

  factory PatientRecord.fromFirestore(Map<String, dynamic> json, String id) =>
      PatientRecord.fromJson(json).copyWith(id: id);
}
