import 'package:equatable/equatable.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/attachment.dart';

class Comment extends Equatable {
  final String content;
  final String id;
  final DateTime postedAt;
  final String? projectId;
  final String taskId;
  final Attachment? attachment;

  const Comment({
    required this.content,
    required this.id,
    required this.postedAt,
    this.projectId,
    required this.taskId,
    this.attachment,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'id': id,
      'posted_at': postedAt.toIso8601String(),
      'project_id': projectId,
      'task_id': taskId,
      'attachment': attachment?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    content,
    id,
    postedAt,
    projectId,
    taskId,
    attachment,
  ];
}