part of 'onboarding_bloc.dart';

@freezed
abstract class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.pageChanged(int page) = _PageChanged;
  const factory OnboardingEvent.termsAccepted(bool accepted) = _TermsAccepted;
  const factory OnboardingEvent.completed() = _Completed;
}
