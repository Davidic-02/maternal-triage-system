part of 'triage_bloc.dart';

@freezed
abstract class TriageEvent with _$TriageEvent {
  const factory TriageEvent.started() = _Started;
  const factory TriageEvent.filterChanged(TriageFilter filter) = _FilterChanged;
  const factory TriageEvent.searchChanged(String query) = _SearchChanged;
  const factory TriageEvent.resolvePatient(String patientId) = _ResolvePatient;
  const factory TriageEvent.activeQueueUpdated(List<PatientRecord> records) =
      _ActiveQueueUpdated;
  const factory TriageEvent.resolvedTodayUpdated(List<PatientRecord> records) =
      _ResolvedTodayUpdated;
  const factory TriageEvent.errorOccurred(String message) = _ErrorOccurred;
}
