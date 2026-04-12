part of 'education_bloc.dart';

@freezed
abstract class EducationState with _$EducationState {
  const EducationState._();

  const factory EducationState({
    @Default(EducationStatus.initial) EducationStatus status,
    @Default([]) List<EducationVideo> allVideos,
    @Default([]) List<EducationGuide> allGuides,
    @Default('third') String selectedTab,
    @Default('') String searchQuery,

    String? errorMessage,
    DateTime? lastFetched,
  }) = _EducationState;

  List<EducationVideo> get featuredVideos => allVideos
      .where((v) => v.trimesterTag == selectedTab && v.isFeatured)
      .toList();

  List<EducationVideo> get sectionVideos => allVideos
      .where((v) => v.trimesterTag == selectedTab && !v.isFeatured)
      .toList();

  List<EducationGuide> get filteredGuides {
    if (searchQuery.isEmpty) return allGuides;
    final q = searchQuery.toLowerCase();
    return allGuides
        .where(
          (g) =>
              g.title.toLowerCase().contains(q) ||
              g.subtitle.toLowerCase().contains(q) ||
              g.summary.toLowerCase().contains(q),
        )
        .toList();
  }

  List<EducationVideo> get filteredVideos {
    if (searchQuery.isEmpty) {
      return allVideos.where((v) => v.trimesterTag == selectedTab).toList();
    }
    final q = searchQuery.toLowerCase();
    return allVideos
        .where(
          (v) =>
              v.trimesterTag == selectedTab &&
              (v.title.toLowerCase().contains(q) ||
                  v.subtitle.toLowerCase().contains(q)),
        )
        .toList();
  }
}
