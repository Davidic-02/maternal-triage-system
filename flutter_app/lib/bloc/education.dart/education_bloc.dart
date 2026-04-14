import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maternal_triage/models/education_content.dart';
import 'package:maternal_triage/services/educational_service.dart';
import '../../services/logging_helper.dart';

import 'package:maternal_triage/enums/education_enum.dart';

part 'education_event.dart';
part 'education_state.dart';
part 'education_bloc.freezed.dart';

class EducationBloc extends Bloc<EducationEvent, EducationState> {
  final EducationService _service;

  EducationBloc({EducationService? service})
    : _service = service ?? EducationService(),
      super(const EducationState()) {
    on<_TabChanged>(_onTabChanged);
    on<_SearchChanged>(_onSearchChanged);
    on<_Refresh>(_onRefresh);
    on<_Init>(_onInit);
    add(const EducationEvent.init());
  }

  Future<void> _onInit(_Init event, Emitter<EducationState> emit) async {
    emit(state.copyWith(status: EducationStatus.loading));
    await _load(emit, forceRefresh: false);
  }

  Future<void> _onRefresh(_Refresh event, Emitter<EducationState> emit) async {
    emit(state.copyWith(status: EducationStatus.loading));
    await _load(emit, forceRefresh: true);
  }

  void _onTabChanged(_TabChanged event, Emitter<EducationState> emit) {
    emit(state.copyWith(selectedTab: event.tab));
  }

  void _onSearchChanged(_SearchChanged event, Emitter<EducationState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _load(
    Emitter<EducationState> emit, {
    required bool forceRefresh,
  }) async {
    try {
      final cache = await _service.getContent(forceRefresh: forceRefresh);
      emit(
        state.copyWith(
          status: EducationStatus.loaded,
          allVideos: cache.videos,
          allGuides: cache.guides,
          lastFetched: cache.fetchedAt,
        ),
      );
    } catch (e, st) {
      logError(e, st);
      emit(
        state.copyWith(
          status: EducationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
