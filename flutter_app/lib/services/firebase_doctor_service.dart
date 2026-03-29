import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maternal_triage/models/doctor_model.dart';

class DoctorService {
  static const _collection = 'users';
  final FirebaseFirestore _db;

  DoctorService({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance {
    _db.settings = const Settings(persistenceEnabled: true);
  }

  Future<void> saveDoctor(DoctorModel doctor) async {
    await _db.collection(_collection).doc(doctor.uid).set(doctor.toJson());
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    await _db.collection(_collection).doc(doctor.uid).update(doctor.toJson());
  }

  Future<DoctorModel?> getDoctor(String uid) async {
    final doc = await _db.collection(_collection).doc(uid).get();
    if (!doc.exists) return null;
    return DoctorModel.fromFirestore(doc.data()!, doc.id);
  }

  Stream<DoctorModel?> watchDoctor(String uid) {
    return _db.collection(_collection).doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return DoctorModel.fromFirestore(doc.data()!, doc.id);
    });
  }
}
