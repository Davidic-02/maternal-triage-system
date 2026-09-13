part of 'education_bloc.dart';

@freezed
abstract class EducationEvent with _$EducationEvent {
  const factory EducationEvent.tabChanged(String tab) = _TabChanged;
  const factory EducationEvent.searchChanged(String query) = _SearchChanged;
  const factory EducationEvent.refresh() = _Refresh;
  const factory EducationEvent.videoTapped(String youtubeVideoId) =
      _VideoTapped;
  const factory EducationEvent.init() = _Init;
}
