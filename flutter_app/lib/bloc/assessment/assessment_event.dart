part of 'assessment_bloc.dart';

@freezed
abstract class AssessmentEvent with _$AssessmentEvent {
  const factory AssessmentEvent() = _AssessmentEvent;

  const factory AssessmentEvent.runAssessment(PatientRecord patientRecord) =
      _RunAssessment;

  const factory AssessmentEvent.clearAssessment() = _ClearAssessment;
}
