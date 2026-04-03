import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/patient_record.dart';

/// Firestore CRUD service for patient assessment records.
class FirebaseService {
  static const String _collection = 'patient_records';

  final FirebaseFirestore _db;

  FirebaseService({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance {
    // Enable offline persistence
    _db.settings = const Settings(persistenceEnabled: true);
  }

  /// Saves a new [record] and returns the generated document ID.
  Future<String> saveRecord(PatientRecord record) async {
    final ref = await _db.collection(_collection).add(record.toJson());
    return ref.id;
  }

  Future<List<PatientRecord>> getRecords() async {
    final snapshot = await _db
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => PatientRecord.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Stream<List<PatientRecord>> watchRecords() {
    return _db
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => PatientRecord.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> deleteRecord(String id) async {
    await _db.collection(_collection).doc(id).delete();
  }

  /// Updates an existing record.
  Future<void> updateRecord(PatientRecord record) async {
    if (record.id == null) {
      throw ArgumentError('Record must have an ID to be updated.');
    }
    await _db.collection(_collection).doc(record.id).update(record.toJson());
  }

  DateTime get _startOfToday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  Stream<List<PatientRecord>> watchActiveQueue() {
    return _db
        .collection(_collection)
        .where(
          'createdAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(_startOfToday),
        )
        .where('resolved', isEqualTo: false)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => PatientRecord.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  Stream<List<PatientRecord>> watchResolvedToday() {
    return _db
        .collection(_collection)
        .where(
          'createdAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(_startOfToday),
        )
        .where('resolved', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => PatientRecord.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> resolveRecord(String id, String doctorEmail) async {
    await _db.collection(_collection).doc(id).update({
      'resolved': true,
      'resolvedAt': Timestamp.fromDate(DateTime.now()),
      'resolvedBy': doctorEmail,
    });
  }

  Future<PatientRecord?> getRecord(String id) async {
    final doc = await _db.collection(_collection).doc(id).get();
    if (!doc.exists) return null;
    return PatientRecord.fromFirestore(doc.data()!, doc.id);
  }
}
