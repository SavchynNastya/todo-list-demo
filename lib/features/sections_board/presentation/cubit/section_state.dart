import 'package:equatable/equatable.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

enum SectionStatus {
  initial,
  loading,
  success,
  failure,
}

enum FailureType {
  noInternetConnection,
  userUnauthorized,
  unknownFailure,
  badRequestFailure,
}

class SectionState extends Equatable {
  final int? lastFetchTimestamp;
  final int reFetchDelay = 900000;
  final SectionStatus getSectionStatus;
  final SectionStatus getTasksListStatus;
  final SectionStatus getSectionsListStatus;
  final SectionStatus updateSectionStatus;
  final SectionStatus createSectionStatus;
  final SectionStatus deleteSectionStatus;

  final List<Section>? sections;
  final List<Task>? tasks;

  final FailureType? failureType;
  final String? failureMessage;

  const SectionState({
    this.lastFetchTimestamp,
    this.getSectionStatus = SectionStatus.initial,
    this.getTasksListStatus = SectionStatus.initial,
    this.getSectionsListStatus = SectionStatus.initial,
    this.updateSectionStatus = SectionStatus.initial,
    this.createSectionStatus = SectionStatus.initial,
    this.deleteSectionStatus = SectionStatus.initial,
    this.sections,
    this.tasks,
    this.failureType,
    this.failureMessage,
  });

  SectionState copyWith({
    int? lastFetchTimestamp,
    SectionStatus? getSectionStatus,
    SectionStatus? getTasksListStatus,
    SectionStatus? getSectionsListStatus,
    SectionStatus? updateSectionStatus,
    SectionStatus? createSectionStatus,
    SectionStatus? deleteSectionStatus,
    List<Section>? sections,
    List<Task>? tasks,
    FailureType? failureType,
    String? failureMessage,
  }) {
    return SectionState(
      lastFetchTimestamp: lastFetchTimestamp ?? this.lastFetchTimestamp,
      getSectionStatus:
      getSectionStatus ?? this.getSectionStatus,
      getTasksListStatus:
      getTasksListStatus ?? this.getTasksListStatus,
      getSectionsListStatus:
      getSectionsListStatus ?? this.getSectionsListStatus,
      updateSectionStatus:
      updateSectionStatus ?? this.updateSectionStatus,
      createSectionStatus:
      createSectionStatus ?? this.createSectionStatus,
      deleteSectionStatus:
      deleteSectionStatus ?? this.deleteSectionStatus,
      sections: sections ?? this.sections,
      tasks: tasks ?? this.tasks,
      failureType: failureType,
      failureMessage: failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    lastFetchTimestamp,
    getSectionStatus,
    getTasksListStatus,
    getSectionsListStatus,
    updateSectionStatus,
    updateSectionStatus,
    deleteSectionStatus,
    sections,
    tasks,
  ];
}
