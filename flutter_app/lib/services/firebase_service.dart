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
    final ref = await _db.collection(_collection).add(record.toMap());
    return ref.id;
  }

  /// Fetches all records, ordered by creation time (newest first).
  Future<List<PatientRecord>> getRecords() async {
    final snapshot = await _db
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => PatientRecord.fromMap(doc.data(), id: doc.id))
        .toList();
  }

  /// Returns a real-time stream of all records.
  Stream<List<PatientRecord>> watchRecords() {
    return _db
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => PatientRecord.fromMap(doc.data(), id: doc.id))
            .toList());
  }

  /// Deletes a record by [id].
  Future<void> deleteRecord(String id) async {
    await _db.collection(_collection).doc(id).delete();
  }

  /// Updates an existing record.
  Future<void> updateRecord(PatientRecord record) async {
    if (record.id == null) {
      throw ArgumentError('Record must have an ID to be updated.');
    }
    await _db.collection(_collection).doc(record.id).update(record.toMap());
  }
}
