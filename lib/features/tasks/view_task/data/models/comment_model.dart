import 'package:todolist/features/tasks/view_task/domain/entities/attachment.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/comment.dart';
import 'package:todolist/features/tasks/view_task/data/models/attachment_model.dart';

class CommentModel extends Comment {
  const CommentModel({
    required String content,
    required String id,
    required DateTime postedAt,
    String? projectId,
    required String taskId,
    Attachment? attachment,
  }) : super(
    content: content,
    id: id,
    postedAt: postedAt,
    projectId: projectId,
    taskId: taskId,
    attachment: attachment,
  );

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      content: json['content'],
      id: json['id'],
      postedAt: DateTime.parse(json['posted_at']),
      projectId: json['project_id'],
      taskId: json['task_id'],
      attachment: json['attachment'] != null
          ? AttachmentModel.fromJson(json['attachment'])
          : null,
    );
  }

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

  CommentModel copyWith({
    String? content,
    String? id,
    DateTime? postedAt,
    String? projectId,
    String? taskId,
    Attachment? attachment,
  }) {
    return CommentModel(
      content: content ?? this.content,
      id: id ?? this.id,
      postedAt: postedAt ?? this.postedAt,
      projectId: projectId ?? this.projectId,
      taskId: taskId ?? this.taskId,
      attachment: attachment ?? this.attachment,
    );
  }

  @override
  List<Object?> get props => [content, id, postedAt, projectId, taskId, attachment];
}