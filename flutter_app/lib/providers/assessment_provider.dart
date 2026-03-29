import 'package:flutter/foundation.dart';

import '../models/patient_record.dart';
import '../models/risk_result.dart';
import '../services/firebase_patient_service.dart';
import '../services/inference_service.dart';
import '../services/shap_service.dart';

/// State management for the current assessment session.
class AssessmentProvider extends ChangeNotifier {
  final InferenceService _inferenceService;
  final ShapService _shapService;
  final FirebaseService _firebaseService;

  PatientRecord? _currentRecord;
  RiskResult? _currentResult;
  List<PatientRecord> _recentRecords = [];
  bool _isLoading = false;
  String? _errorMessage;

  AssessmentProvider({
    InferenceService? inferenceService,
    ShapService? shapService,
    FirebaseService? firebaseService,
  }) : _inferenceService = inferenceService ?? InferenceService(),
       _shapService = shapService ?? ShapService(),
       _firebaseService = firebaseService ?? FirebaseService();

  PatientRecord? get currentRecord => _currentRecord;
  RiskResult? get currentResult => _currentResult;
  List<PatientRecord> get recentRecords => _recentRecords;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Initialises services; call once during app startup (after Firebase.initializeApp).
  Future<void> initialise() async {
    _setLoading(true);
    try {
      await _inferenceService.loadModel();
      await _shapService.loadShapValues();
      await _loadRecentRecords();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /// Runs inference on [record], stores the result, and saves to Firestore.
  Future<void> runAssessment(PatientRecord record) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _currentRecord = record;

      final inferenceResult = _inferenceService.predict(record);
      final riskClass = inferenceResult['riskClass'] as int;
      final probs = inferenceResult['probabilities'] as List<double>;

      List<ShapFeature> shapFeatures = [];
      if (_shapService.isLoaded) {
        // Use index 0 as a proxy for local explanation when index is unknown
        shapFeatures = _shapService.getLocalExplanation(
          index: 0,
          predictedClass: riskClass,
        );
      }

      _currentResult = RiskResult(
        riskClass: riskClass,
        probabilities: probs,
        shapFeatures: shapFeatures,
      );

      await _firebaseService.saveRecord(record);
      await _loadRecentRecords();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadRecentRecords() async {
    _recentRecords = await _firebaseService.getRecords();
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearAssessment() {
    _currentRecord = null;
    _currentResult = null;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _inferenceService.dispose();
    super.dispose();
  }
}
