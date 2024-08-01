import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:todolist/features/tasks/create_task/data/models/task_model.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/attachment.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/comment.dart';
import 'package:todolist/features/tasks/view_task/data/models/comment_model.dart';

abstract class TaskDetailsDatasource {
  Future<Task> getTaskDetails(String taskId);

  Future<Comment> createComment(String taskId, String content, Attachment? attachment);

  Future<List<Comment>> getTaskComments(String taskId);

  Future<Task> updateTask(
    String taskId,
    String? content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  );

  Future<bool> deleteTask(String taskId);

  Future<bool> closeTask(String taskId);
}

class TaskDetailsDatasourceImpl extends TaskDetailsDatasource {
  TaskDetailsDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<Task> getTaskDetails(String taskId) async {
    try {
      final response = await dio.get('/rest/v2/tasks/$taskId');
      return TaskModel.fromJson(response.data);
    } catch (e, st) {
      Fimber.e('Error getting task details: $e', stacktrace: st);
      throw Exception('Failed to load task details');
    }
  }

  @override
  Future<Comment> createComment(
    String taskId,
    String content,
    Attachment? attachment,
  ) async {
    FormData formData = FormData.fromMap({
      'task_id': taskId,
      'content': content,
    });
    try {
      final response = await dio.post(
        '/rest/v2/comments',
        data: formData,
      );
      return CommentModel.fromJson(response.data);
    } catch (e, st) {
      Fimber.e('Error creating comment: $e', stacktrace: st);
      throw Exception('Failed to create comment');
    }
  }

  @override
  Future<List<Comment>> getTaskComments(String taskId) async {
    try {
      final response = await dio.get(
        '/rest/v2/comments?task_id=$taskId',
      );
      return (response.data as List)
          .map((commentJson) => CommentModel.fromJson(commentJson))
          .toList();
    } catch (e, st) {
      Fimber.e('Error creating comment: $e', stacktrace: st);
      throw Exception('Failed to create comment');
    }
  }

  @override
  Future<Task> updateTask(
    String taskId,
    String? content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  ) async {
    FormData formData = FormData.fromMap({
      'content': content,
      'description': description,
      'labels': labels,
      'priority': priority,
      'due_datetime': dueDatetime,
      'duration': duration,
      'duration_unit': durationUnit
    });

    try {
      final response = await dio.post(
        '/rest/v2/tasks/$taskId',
        data: formData,
      );
      return TaskModel.fromJson(response.data);
    } catch (e, st) {
      Fimber.e('Error updating task: $e', stacktrace: st);
      throw Exception('Failed to update task');
    }
  }

  @override
  Future<bool> deleteTask(String taskId) async {
    try {
      await dio.delete('/rest/v2/tasks/$taskId');
      return true;
    } catch (e, st) {
      Fimber.e('Error deleting task: $e', stacktrace: st);
      throw Exception('Failed to delete task');
    }
  }

  @override
  Future<bool> closeTask(String taskId) async {
    try {
      await dio.post('/rest/v2/tasks/$taskId/close');
      return true;
    } catch (e, st) {
      Fimber.e('Error closing task: $e', stacktrace: st);
      throw Exception('Failed to close task');
    }
  }
}
