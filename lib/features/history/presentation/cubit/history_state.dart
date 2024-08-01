import 'package:equatable/equatable.dart';
import 'package:todolist/features/history/domain/entities/task_item.dart';

enum HistoryStatus {
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

class HistoryState extends Equatable {
  final int? lastFetchTimestamp;
  final int reFetchDelay = 900000;
  final HistoryStatus getCompletedTaskListStatus;
  final List<TaskItem>? completedTasks;
  final FailureType? failureType;
  final String? failureMessage;

  const HistoryState({
    this.lastFetchTimestamp,
    this.getCompletedTaskListStatus = HistoryStatus.initial,
    this.completedTasks,
    this.failureType,
    this.failureMessage,
  });

  HistoryState copyWith({
    int? lastFetchTimestamp,
    HistoryStatus? getCompletedTaskListStatus,
    List<TaskItem>? completedTasks,
    FailureType? failureType,
    String? failureMessage,
  }) {
    return HistoryState(
      lastFetchTimestamp: lastFetchTimestamp ?? this.lastFetchTimestamp,
      getCompletedTaskListStatus: getCompletedTaskListStatus ?? this.getCompletedTaskListStatus,
      completedTasks: completedTasks ?? this.completedTasks,
      failureType: failureType ?? this.failureType,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    lastFetchTimestamp,
    getCompletedTaskListStatus,
    completedTasks,
    failureType,
    failureMessage,
  ];
}
