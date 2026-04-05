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
    String? patientNameOrId,       // ← add for identification
    double? gestationalAge,        // ← add for clinical context
    double? fetalHeartRate,        // ← add for clinical context
    required double age,
    required double systolicBP,
    required double diastolicBP,
    required double bloodSugar,
    required double bodyTemp,
    required double heartRate,
    double? weight,
    double? height,
    @Default(0) int riskClass,
    @Default(false) bool previousComplications,
    @Default(false) bool preexistingDiabetes,
    @Default(false) bool gestationalDiabetes,
    @Default(false) bool hypertension,             // ← add from design
    @Default(false) bool blurredVision,
    @Default(false) bool vaginalBleeding,
    @Default(false) bool severeSwelling,
    @Default(false) bool reducedFetalMovement,
    @Default('none') String mentalHealthStatus,
    @Default(false) bool resolved,
    @TimestampConverter() DateTime? resolvedAt,
    String? resolvedBy,
    @TimestampConverter() required DateTime createdAt,
    String? assessedBy,
    String? hospitalId,
  }) = _PatientRecord;

  // ── derived fields ────────────────────────────────
  double get pulsePressure => systolicBP - diastolicBP;

  double? get bmi {
    if (weight == null || height == null || height! <= 0) return null;
    final heightM = height! / 100; // height in cm → meters
    return weight! / (heightM * heightM);
  }

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