import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/sections_board/domain/repositories/section_repository.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_state.dart';

class SectionCubit extends Cubit<SectionState> {
  final SectionRepository sectionRepository;

  SectionCubit({required this.sectionRepository}) : super(const SectionState());

  getSectionsList() async {
    emit(state.copyWith(
      getSectionsListStatus: SectionStatus.loading,
    ));

    final result = await sectionRepository.getSectionsList();

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            getSectionsListStatus: SectionStatus.failure,
          ),
        );
      },
      (data) {
        return emit(state.copyWith(
          sections: data,
          getSectionsListStatus: SectionStatus.success,
        ));
      },
    );
  }

  createSection(String sectionName) async {
    emit(state.copyWith(
      createSectionStatus: SectionStatus.loading,
    ));

    final result = await sectionRepository.createSection(sectionName);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            createSectionStatus: SectionStatus.failure,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            createSectionStatus: SectionStatus.success,
          ),
        );
      },
    );

    getSectionsList();
  }

  getSection(String sectionId) async {
    emit(state.copyWith(
      getSectionStatus: SectionStatus.loading,
    ));

    final result = await sectionRepository.getSection(sectionId);

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            getSectionStatus: SectionStatus.failure,
          ),
        );
      },
      (data) {
        return emit(state.copyWith(
          sections: [data],
          getSectionStatus: SectionStatus.success,
        ));
      },
    );
  }

  getTasksList(String? sectionId, String? label) async {
    emit(state.copyWith(
      getTasksListStatus: SectionStatus.loading,
    ));

    final result = await sectionRepository.getTasksList(sectionId, label);

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            getTasksListStatus: SectionStatus.failure,
          ),
        );
      },
      (data) {
        return emit(state.copyWith(
          tasks: data,
          getTasksListStatus: SectionStatus.success,
        ));
      },
    );
  }

  updateSection(String sectionId, String sectionName) async {
    emit(state.copyWith(
      updateSectionStatus: SectionStatus.loading,
    ));

    final result = await sectionRepository.updateSection(sectionId, sectionName);

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            updateSectionStatus: SectionStatus.failure,
          ),
        );
      },
      (data) {
        sectionRepository.getSectionsList().then(
          (result) {
            result.fold(
              (l) => emit(
                state.copyWith(
                  updateSectionStatus: SectionStatus.failure,
                ),
              ),
              (data) => emit(
                state.copyWith(
                  sections: data,
                  updateSectionStatus: SectionStatus.success,
                ),
              ),
            );
          },
        );
      },
    );
  }

  deleteSection(String sectionId) async {
    emit(state.copyWith(
      deleteSectionStatus: SectionStatus.loading,
    ));

    final result = await sectionRepository.deleteSection(sectionId);

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            deleteSectionStatus: SectionStatus.failure,
          ),
        );
      },
      (data) {
        sectionRepository.getSectionsList().then(
          (result) {
            result.fold(
              (l) => emit(
                state.copyWith(
                  deleteSectionStatus: SectionStatus.failure,
                ),
              ),
              (data) => emit(
                state.copyWith(
                  sections: data,
                  deleteSectionStatus: SectionStatus.success,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
