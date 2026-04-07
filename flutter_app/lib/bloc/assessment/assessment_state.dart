part of 'assessment_bloc.dart';

@freezed
abstract class AssessmentState with _$AssessmentState {
  const AssessmentState._();

  const factory AssessmentState({
    PatientRecord? record,
    RiskResult? result,
    String? clinicalExplanation,
    @Default(false) bool isGeneratingExplanation,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    String? errorMessage,
  }) = _AssessmentState;
}
