part of 'triadge_bloc.dart';

import 'package:maternal_triage/models/patient_record.dart';

@freezed
abstract class TriadgeEvent with _$TriadgeEvent {
  const factory TriageEvent.started() = _Started;
  const factory TriadgeEvent.onClicked() = _Onclicked;
  const factory TriageEvent.filterChanged(String filter) = _FilterChanged;
  const factory TriageEvent.searchChanged(String query) = _SearchChanged;
  const factory TriageEvent.resolvePatient(String patientId) = _ResolvePatient;

  const factory TriadgeEvent.activeQueueUpdated(List<PatientRecord> records) =
      _ActiveQueueUpdated;
  const factory TriageEvent.resolvedTodayUpdated(List<PatientRecord> records) =
      _ResolvedTodayUpdated;
  const factory TriageEvent.errorOccurred(String message) = _ErrorOccurred;
}

List<PatientRecord> get filteredQueue {
  var records = activeQueue;

  // apply risk filter
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
      return
        // search by doctor name
        (r.assessedBy?.toLowerCase().contains(query) ?? false) ||
        // search by age
        r.age.toString().contains(query) ||
        // search by blood pressure
        r.systolicBP.toString().contains(query) ||
        r.diastolicBP.toString().contains(query) ||
        // search by risk label
        _riskLabel(r.riskClass).toLowerCase().contains(query) ||
        // search by mental health status
        r.mentalHealthStatus.toLowerCase().contains(query) ||
        // search by date
        r.createdAt.toString().contains(query);
    }).toList();
  }

  // sort by risk — highest first
  records.sort((a, b) => b.riskClass.compareTo(a.riskClass));

  return records;
}

// helper — keeps state clean
String _riskLabel(int riskClass) {
  switch (riskClass) {
    case 0: return 'low';
    case 1: return 'moderate';
    case 2: return 'high';
    default: return '';
  }
}

