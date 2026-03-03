import 'package:cloud_firestore/cloud_firestore.dart';

/// Data model representing a single patient assessment record.
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
  final bool previousComplications;
  final bool preexistingDiabetes;
  final bool gestationalDiabetes;
  final String mentalHealthStatus;
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

  Map<String, dynamic> toMap() => {
        'age': age,
        'systolicBP': systolicBP,
        'diastolicBP': diastolicBP,
        'bloodSugar': bloodSugar,
        'bodyTemp': bodyTemp,
        'heartRate': heartRate,
        'weight': weight,
        'height': height,
        'previousComplications': previousComplications,
        'preexistingDiabetes': preexistingDiabetes,
        'gestationalDiabetes': gestationalDiabetes,
        'mentalHealthStatus': mentalHealthStatus,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  factory PatientRecord.fromMap(Map<String, dynamic> map, {String? id}) =>
      PatientRecord(
        id: id,
        age: (map['age'] as num).toDouble(),
        systolicBP: (map['systolicBP'] as num).toDouble(),
        diastolicBP: (map['diastolicBP'] as num).toDouble(),
        bloodSugar: (map['bloodSugar'] as num).toDouble(),
        bodyTemp: (map['bodyTemp'] as num).toDouble(),
        heartRate: (map['heartRate'] as num).toDouble(),
        weight: map['weight'] != null ? (map['weight'] as num).toDouble() : null,
        height: map['height'] != null ? (map['height'] as num).toDouble() : null,
        previousComplications: map['previousComplications'] as bool? ?? false,
        preexistingDiabetes: map['preexistingDiabetes'] as bool? ?? false,
        gestationalDiabetes: map['gestationalDiabetes'] as bool? ?? false,
        mentalHealthStatus: map['mentalHealthStatus'] as String? ?? 'none',
        createdAt: (map['createdAt'] as Timestamp).toDate(),
      );
}
