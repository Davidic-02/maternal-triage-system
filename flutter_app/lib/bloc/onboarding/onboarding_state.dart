part of 'onboarding_bloc.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentPage,
    @Default(false) bool hasAcceptedTerms,
    @Default(false) bool isCompleted,
  }) = _OnboardingState;
}
