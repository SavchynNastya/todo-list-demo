import 'package:equatable/equatable.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/label.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/comment.dart';

enum TaskDetailsStatus {
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

class TaskDetailsState extends Equatable {
  final int? lastFetchTimestamp;
  final int reFetchDelay = 900000;
  final TaskDetailsStatus getTaskDetailsStatus;
  final TaskDetailsStatus createCommentStatus;
  final TaskDetailsStatus getTaskCommentsStatus;
  final TaskDetailsStatus updateTaskStatus;
  final TaskDetailsStatus deleteTaskStatus;
  final TaskDetailsStatus closeTaskStatus;
  final TaskDetailsStatus getDueTasksListStatus;
  final TaskDetailsStatus getTodayTasksListStatus;
  final Task? task;
  final List<Comment>? comments;
  final List<Task>? todayTasks;
  final List<Task>? dueTasks;
  final List<Label>? labels;

  final FailureType? failureType;
  final String? failureMessage;

  const TaskDetailsState({
    this.lastFetchTimestamp,
    this.getTaskDetailsStatus = TaskDetailsStatus.initial,
    this.createCommentStatus = TaskDetailsStatus.initial,
    this.getTaskCommentsStatus = TaskDetailsStatus.initial,
    this.updateTaskStatus = TaskDetailsStatus.initial,
    this.deleteTaskStatus = TaskDetailsStatus.initial,
    this.closeTaskStatus = TaskDetailsStatus.initial,
    this.getDueTasksListStatus = TaskDetailsStatus.initial,
    this.getTodayTasksListStatus = TaskDetailsStatus.initial,
    this.comments,
    this.task,
    this.todayTasks,
    this.dueTasks,
    this.labels,
    this.failureType,
    this.failureMessage,
  });

  TaskDetailsState copyWith({
    int? lastFetchTimestamp,
    TaskDetailsStatus? getTaskDetailsStatus,
    TaskDetailsStatus? createCommentStatus,
    TaskDetailsStatus? getTaskCommentsStatus,
    TaskDetailsStatus? updateTaskStatus,
    TaskDetailsStatus? deleteTaskStatus,
    TaskDetailsStatus? closeTaskStatus,
    TaskDetailsStatus? getDueTasksListStatus,
    TaskDetailsStatus? getTodayTasksListStatus,
    List<Comment>? comments,
    Task? task,
    List<Task>? todayTasks,
    List<Task>? dueTasks,
    List<Label>? labels,
    FailureType? failureType,
    String? failureMessage,
  }) {
    return TaskDetailsState(
      lastFetchTimestamp: lastFetchTimestamp ?? this.lastFetchTimestamp,
      getTaskDetailsStatus:
      getTaskDetailsStatus ?? this.getTaskDetailsStatus,
      createCommentStatus:
      createCommentStatus ?? this.createCommentStatus,
      getTaskCommentsStatus:
      getTaskCommentsStatus ?? this.getTaskCommentsStatus,
      updateTaskStatus:
      updateTaskStatus ?? this.updateTaskStatus,
      deleteTaskStatus:
      deleteTaskStatus ?? this.deleteTaskStatus,
      closeTaskStatus:
      closeTaskStatus ?? this.closeTaskStatus,
      getDueTasksListStatus:
      getDueTasksListStatus ?? this.getDueTasksListStatus,
      getTodayTasksListStatus:
      getTodayTasksListStatus ?? this.getTodayTasksListStatus,
      comments: comments ?? this.comments,
      task: task ?? this.task,
      todayTasks: todayTasks ?? this.todayTasks,
      dueTasks: dueTasks ?? this.dueTasks,
      labels: labels ?? this.labels,
      failureType: failureType,
      failureMessage: failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    lastFetchTimestamp,
    getTaskDetailsStatus,
    createCommentStatus,
    getTaskCommentsStatus,
    updateTaskStatus,
    deleteTaskStatus,
    closeTaskStatus,
    getDueTasksListStatus,
    getTodayTasksListStatus,
    comments,
    task,
    dueTasks,
    todayTasks,
    labels,
  ];
}
