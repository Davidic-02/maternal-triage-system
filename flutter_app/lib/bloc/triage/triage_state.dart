part of 'triage_bloc.dart';

@freezed
abstract class TriageState with _$TriageState {
  const TriageState._();

  const factory TriageState({
    @Default(TriageStatus.initial) TriageStatus status,
    @Default([]) List<PatientRecord> activeQueue,
    @Default([]) List<PatientRecord> resolvedToday,
    @Default(TriageFilter.all) TriageFilter filter,
    @Default('') String searchQuery,
    String? errorMessage,
  }) = _TriageState;

  // summary counts
  int get emergencyCount => activeQueue.where((r) => r.riskClass == 2).length;
  int get urgentCount => activeQueue.where((r) => r.riskClass == 1).length;
  int get stableCount => activeQueue.where((r) => r.riskClass == 0).length;

  List<PatientRecord> get filteredQueue {
    var records = List<PatientRecord>.from(activeQueue);

    switch (filter) {
      case TriageFilter.high:
        records = records.where((r) => r.riskClass == 2).toList();
        break;
      case TriageFilter.moderate:
        records = records.where((r) => r.riskClass == 1).toList();
        break;
      case TriageFilter.low:
        records = records.where((r) => r.riskClass == 0).toList();
        break;
      case TriageFilter.all:
        break;
    }

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      records = records.where((r) {
        return (r.assessedBy?.toLowerCase().contains(query) ?? false) ||
            r.age.toString().contains(query) ||
            r.systolicBP.toString().contains(query) ||
            r.diastolicBP.toString().contains(query) ||
            _riskLabel(r.riskClass).toLowerCase().contains(query) ||
            r.mentalHealthStatus.toLowerCase().contains(query) ||
            r.createdAt.toString().contains(query);
      }).toList();
    }
    final sorted = List<PatientRecord>.from(records);
    records.sort((a, b) => b.riskClass.compareTo(a.riskClass));
    return sorted;
  }

  // filtered resolved today
  List<PatientRecord> get filteredResolved {
    if (searchQuery.isEmpty) {
      final sorted = List<PatientRecord>.from(resolvedToday);
      sorted.sort((a, b) => b.riskClass.compareTo(a.riskClass));
      return sorted;
    }

    final query = searchQuery.toLowerCase();
    final filtered = resolvedToday.where((r) {
      return (r.assessedBy?.toLowerCase().contains(query) ?? false) ||
          r.age.toString().contains(query) ||
          r.systolicBP.toString().contains(query) ||
          r.diastolicBP.toString().contains(query) ||
          _riskLabel(r.riskClass).toLowerCase().contains(query) ||
          r.mentalHealthStatus.toLowerCase().contains(query) ||
          r.createdAt.toString().contains(query);
    }).toList();

    filtered.sort((a, b) => b.riskClass.compareTo(a.riskClass));
    return filtered;
  }

  String _riskLabel(int riskClass) {
    switch (riskClass) {
      case 0:
        return 'low';
      case 1:
        return 'moderate';
      case 2:
        return 'high';
      default:
        return '';
    }
  }
}
