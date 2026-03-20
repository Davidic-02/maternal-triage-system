import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maternal_triage/services/persistence_services.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';
part 'onboarding_bloc.freezed.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final PersistenceService _persistenceService;

  OnboardingBloc({PersistenceService? persistenceService})
      : _persistenceService = persistenceService ?? PersistenceService(),
        super(const OnboardingState()) {
    on<_PageChanged>(_onPageChanged);
    on<_TermsAccepted>(_onTermsAccepted);
    on<_Completed>(_onCompleted);
  }

  void _onPageChanged(_PageChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentPage: event.page));
  }

  void _onTermsAccepted(_TermsAccepted event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(hasAcceptedTerms: event.accepted));
  }

  Future<void> _onCompleted(
    _Completed event,
    Emitter<OnboardingState> emit,
  ) async {
    await _persistenceService.saveOnboardingComplete();
    emit(state.copyWith(isCompleted: true));
  }
}
