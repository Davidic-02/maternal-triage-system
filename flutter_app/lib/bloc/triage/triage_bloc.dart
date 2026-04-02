import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maternal_triage/bloc/auth/auth_bloc.dart';
import 'package:maternal_triage/enums/risk_enum.dart';
import 'package:maternal_triage/models/patient_record.dart';
import 'package:maternal_triage/services/firebase_patient_service.dart';
import '../../services/logging_helper.dart';

part 'triage_event.dart';
part 'triage_state.dart';
part 'triage_bloc.freezed.dart';

class TriageBloc extends Bloc<TriageEvent, TriageState> {
  final FirebaseService _firebaseService;
  final AuthBloc _authBloc;

  StreamSubscription<List<PatientRecord>>? _activeQueueSubscription;
  StreamSubscription<List<PatientRecord>>? _resolvedTodaySubscription;

  TriageBloc({required AuthBloc authBloc, FirebaseService? firebaseService})
    : _authBloc = authBloc,
      _firebaseService = firebaseService ?? FirebaseService(),
      super(const TriageState()) {
    on<_Started>(_onStarted);
    on<_FilterChanged>(_onFilterChanged);
    on<_SearchChanged>(_onSearchChanged);
    on<_ResolvePatient>(_onResolvePatient);
    on<_ActiveQueueUpdated>(_onActiveQueueUpdated);
    on<_ResolvedTodayUpdated>(_onResolvedTodayUpdated);
    on<_ErrorOccurred>(_onErrorOccurred);
    add(const TriageEvent.started());
  }

  // ── started ──────────────────────────────────────────────────

  void _onStarted(_Started event, Emitter<TriageState> emit) {
    emit(state.copyWith(status: TriageStatus.loading));

    _activeQueueSubscription?.cancel();
    _resolvedTodaySubscription?.cancel();

    _activeQueueSubscription = _firebaseService.watchActiveQueue().listen(
      (records) => add(TriageEvent.activeQueueUpdated(records)),
      onError: (e) => add(TriageEvent.errorOccurred(e.toString())),
    );

    _resolvedTodaySubscription = _firebaseService.watchResolvedToday().listen(
      (records) => add(TriageEvent.resolvedTodayUpdated(records)),
      onError: (e) => add(TriageEvent.errorOccurred(e.toString())),
    );
  }

  // ── queue updates ────────────────────────────────────────────

  void _onActiveQueueUpdated(
    _ActiveQueueUpdated event,
    Emitter<TriageState> emit,
  ) {
    emit(
      state.copyWith(status: TriageStatus.loaded, activeQueue: event.records),
    );
  }

  void _onResolvedTodayUpdated(
    _ResolvedTodayUpdated event,
    Emitter<TriageState> emit,
  ) {
    emit(
      state.copyWith(status: TriageStatus.loaded, resolvedToday: event.records),
    );
  }

  // ── filter + search ──────────────────────────────────────────

  void _onFilterChanged(_FilterChanged event, Emitter<TriageState> emit) {
    emit(state.copyWith(filter: event.filter));
  }

  void _onSearchChanged(_SearchChanged event, Emitter<TriageState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  // ── resolve patient ──────────────────────────────────────────

  Future<void> _onResolvePatient(
    _ResolvePatient event,
    Emitter<TriageState> emit,
  ) async {
    try {
      final doctorEmail = _authBloc.state.userEmail ?? '';
      await _firebaseService.resolveRecord(event.patientId, doctorEmail);
      logInfo('Patient ${event.patientId} resolved by $doctorEmail');
      // stream updates UI automatically — no emit needed
    } catch (e, st) {
      logError(e, st);
      add(TriageEvent.errorOccurred(e.toString()));
    }
  }

  // ── error ────────────────────────────────────────────────────

  void _onErrorOccurred(_ErrorOccurred event, Emitter<TriageState> emit) {
    emit(
      state.copyWith(status: TriageStatus.error, errorMessage: event.message),
    );
  }

  // ── dispose ──────────────────────────────────────────────────

  @override
  Future<void> close() {
    _activeQueueSubscription?.cancel();
    _resolvedTodaySubscription?.cancel();
    return super.close();
  }
}
