import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_record.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class PatientRecord {
  final String? id;
  final double age;
  final double systolicBP;
  final double diastolicBP;
  final double bloodSugar;
  final double bodyTemp;
  final double heartRate;
  final double? weight;
  final double? height;

  @JsonKey(defaultValue: false)
  final bool previousComplications;

  @JsonKey(defaultValue: false)
  final bool preexistingDiabetes;

  @JsonKey(defaultValue: false)
  final bool gestationalDiabetes;

  @JsonKey(defaultValue: 'none')
  final String mentalHealthStatus;

  @TimestampConverter()
  final DateTime createdAt;

  const PatientRecord({
    this.id,
    required this.age,
    required this.systolicBP,
    required this.diastolicBP,
    required this.bloodSugar,
    required this.bodyTemp,
    required this.heartRate,
    this.weight,
    this.height,
    required this.previousComplications,
    required this.preexistingDiabetes,
    required this.gestationalDiabetes,
    required this.mentalHealthStatus,
    required this.createdAt,
  });

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

  Map<String, dynamic> toJson() => _$PatientRecordToJson(this);
}
