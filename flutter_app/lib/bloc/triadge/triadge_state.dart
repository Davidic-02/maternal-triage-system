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

  int get emergencyCount => activeQueue.where((r) => r.riskClass == 2).length;
  int get urgentCount => activeQueue.where((r) => r.riskClass == 1).length;
  int get stableCount => activeQueue.where((r) => r.riskClass == 0).length;
}
