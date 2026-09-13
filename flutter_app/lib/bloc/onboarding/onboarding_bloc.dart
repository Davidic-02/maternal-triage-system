import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maternal_triage/services/persistence_services.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';
part 'onboarding_bloc.freezed.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final PersistenceService _persistenceService;
  Timer? _autoAdvanceTimer;

  OnboardingBloc({PersistenceService? persistenceService})
    : _persistenceService = persistenceService ?? PersistenceService(),
      super(const OnboardingState()) {
    on<_PageChanged>(_onPageChanged);
    on<_NextPageRequested>(_onNextPageRequested);
    on<_TermsAccepted>(_onTermsAccepted);
    on<_Completed>(_onCompleted);
    on<_AutoAdvance>(_onAutoAdvance); // ✅

    _startTimer(); // ✅ kick off on creation
  }

  // ✅ starts/restarts the 7-second timer
  void _startTimer() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = Timer.periodic(const Duration(seconds: 7), (_) {
      add(const OnboardingEvent.autoAdvance());
    });
  }

  void _onAutoAdvance(_AutoAdvance event, Emitter<OnboardingState> emit) {
    final nextPage = state.currentPage + 1;
    if (nextPage <= 2) {
      emit(state.copyWith(currentPage: nextPage));
    } else {
      // last page reached, stop timer
      _autoAdvanceTimer?.cancel();
    }
  }

  void _onPageChanged(_PageChanged event, Emitter<OnboardingState> emit) {
    _startTimer(); // ✅ reset timer when user swipes manually
    emit(state.copyWith(currentPage: event.page));
  }

  void _onNextPageRequested(
    _NextPageRequested event,
    Emitter<OnboardingState> emit,
  ) {
    _startTimer(); // ✅ reset timer on button tap
    final nextPage = state.currentPage + 1;
    if (nextPage <= 2) {
      emit(state.copyWith(currentPage: nextPage));
    }
  }

  void _onTermsAccepted(_TermsAccepted event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(hasAcceptedTerms: event.accepted));
  }

  Future<void> _onCompleted(
    _Completed event,
    Emitter<OnboardingState> emit,
  ) async {
    _autoAdvanceTimer?.cancel(); // ✅ stop timer when done
    await _persistenceService.saveOnboardingComplete();
    emit(state.copyWith(isCompleted: true));
  }

  @override
  Future<void> close() {
    _autoAdvanceTimer?.cancel(); // ✅ always clean up
    return super.close();
  }
}
