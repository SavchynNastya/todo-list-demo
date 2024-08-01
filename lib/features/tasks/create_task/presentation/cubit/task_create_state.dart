import 'package:equatable/equatable.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/label.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

enum TaskCreateStatus {
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

class TaskCreateState extends Equatable {
  final int? lastFetchTimestamp;
  final int reFetchDelay = 900000;
  final TaskCreateStatus createTaskStatus;
  final TaskCreateStatus createLabelStatus;
  final Task? task;
  final List<Label>? labels;

  final FailureType? failureType;
  final String? failureMessage;

  const TaskCreateState({
    this.lastFetchTimestamp,
    this.createTaskStatus = TaskCreateStatus.initial,
    this.createLabelStatus = TaskCreateStatus.initial,
    this.task,
    this.labels,
    this.failureType,
    this.failureMessage,
  });

  TaskCreateState copyWith({
    int? lastFetchTimestamp,
    TaskCreateStatus? createTaskStatus,
    TaskCreateStatus? createLabelStatus,
    Task? task,
    List<Label>? labels,
    FailureType? failureType,
    String? failureMessage,
  }) {
    return TaskCreateState(
      lastFetchTimestamp: lastFetchTimestamp ?? this.lastFetchTimestamp,
      createTaskStatus:
      createTaskStatus ?? this.createTaskStatus,
      createLabelStatus:
      createLabelStatus ?? this.createLabelStatus,
      task: task ?? this.task,
      labels: labels ?? this.labels,
      failureType: failureType,
      failureMessage: failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    lastFetchTimestamp,
    createTaskStatus,
    createLabelStatus,
    task,
    labels,
  ];
}
