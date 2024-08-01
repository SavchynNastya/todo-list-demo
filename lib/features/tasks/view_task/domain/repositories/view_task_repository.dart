import 'package:todolist/core/helpers/types.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/attachment.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/comment.dart';

abstract class TaskDetailsRepository {
  FutureFailable<Task> getTaskDetails(String taskId);

  FutureFailable<Comment> createComment(String taskId, String content, Attachment? attachment);

  FutureFailable<List<Comment>?> getTaskComments(String taskId);

  FutureFailable<Task> updateTask(
    String taskId,
    String? content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  );

  FutureFailable<bool> deleteTask(String taskId);

  FutureFailable<bool> closeTask(String taskId);
}
