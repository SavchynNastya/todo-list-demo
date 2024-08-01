import 'package:dartz/dartz.dart' as dartz;
import 'package:fimber/fimber.dart';
import 'package:todolist/core/errors/failures.dart';
import 'package:todolist/core/helpers/types.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';
import 'package:todolist/features/tasks/view_task/data/datasource/view_task_datasource.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/attachment.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/comment.dart';
import 'package:todolist/features/tasks/view_task/domain/repositories/view_task_repository.dart';

class TaskDetailsRepositoryImpl extends TaskDetailsRepository {
  final TaskDetailsDatasource datasource;

  TaskDetailsRepositoryImpl({
    required this.datasource,
  });

  @override
  FutureFailable<Task> getTaskDetails(String taskId) async {
    try {
      final task = await datasource.getTaskDetails(taskId);
      return dartz.Right(task);
    } catch (e, st) {
      Fimber.e('Error getting task details: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<Comment> createComment(String taskId, String content, Attachment? attachment) async {
    try {
      final createdComment = await datasource.createComment(taskId, content, attachment);
      return dartz.Right(createdComment);
    } catch (e, st) {
      Fimber.e('Error creating comment: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<List<Comment>?> getTaskComments(String taskId) async {
    try {
      final taskComments = await datasource.getTaskComments(taskId);
      return dartz.Right(taskComments);
    } catch (e, st) {
      Fimber.e('Error creating comment: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<Task> updateTask(
    String taskId,
    String? content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  ) async {
    try {
      final updatedTask = await datasource.updateTask(
        taskId,
        content,
        description,
        labels,
        priority,
        dueDatetime,
        duration,
        durationUnit,
      );
      return dartz.Right(updatedTask);
    } catch (e, st) {
      Fimber.e('Error updating task: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<bool> deleteTask(String taskId) async {
    try {
      await datasource.deleteTask(taskId);
      return const dartz.Right(true);
    } catch (e, st) {
      Fimber.e('Error deleting task: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<bool> closeTask(String taskId) async {
    try {
      await datasource.closeTask(taskId);
      return const dartz.Right(true);
    } catch (e, st) {
      Fimber.e('Error closing task: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }
}
