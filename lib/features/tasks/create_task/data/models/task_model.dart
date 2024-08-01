import 'package:todolist/features/tasks/create_task/data/models/due_model.dart';
import 'package:todolist/features/tasks/create_task/data/models/duration_model.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/due.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/duration.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required String creatorId,
    required DateTime createdAt,
    required String? assigneeId,
    required String? assignerId,
    required int commentCount,
    required bool isCompleted,
    required String content,
    required String? description,
    required Due? due,
    required TaskDuration? duration,
    required String id,
    required List<String>? labels,
    required int? order,
    required int? priority,
    required String? projectId,
    required String? sectionId,
    required String? parentId,
    required String url,
  }) : super(
    creatorId: creatorId,
    createdAt: createdAt,
    assigneeId: assigneeId,
    assignerId: assignerId,
    commentCount: commentCount,
    isCompleted: isCompleted,
    content: content,
    description: description,
    due: due,
    duration: duration,
    id: id,
    labels: labels,
    order: order,
    priority: priority,
    projectId: projectId,
    sectionId: sectionId,
    parentId: parentId,
    url: url,
  );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      creatorId: json['creator_id'],
      createdAt: DateTime.parse(json['created_at']),
      assigneeId: json['assignee_id'],
      assignerId: json['assigner_id'],
      commentCount: json['comment_count'],
      isCompleted: json['is_completed'],
      content: json['content'],
      description: json['description'],
      due: DueModel.fromJson(json['due']),
      duration: TaskDurationModel.fromJson(json['duration']),
      id: json['id'],
      labels: List<String>.from(json['labels']),
      order: json['order'],
      priority: json['priority'],
      projectId: json['project_id'],
      sectionId: json['section_id'],
      parentId: json['parent_id'],
      url: json['url'],
    );
  }

  TaskModel copyWith({
    String? creatorId,
    DateTime? createdAt,
    String? assigneeId,
    String? assignerId,
    int? commentCount,
    bool? isCompleted,
    String? content,
    String? description,
    Due? due,
    TaskDuration? duration,
    String? id,
    List<String>? labels,
    int? order,
    int? priority,
    String? projectId,
    String? sectionId,
    String? parentId,
    String? url,
  }) {
    return TaskModel(
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      assigneeId: assigneeId ?? this.assigneeId,
      assignerId: assignerId ?? this.assignerId,
      commentCount: commentCount ?? this.commentCount,
      isCompleted: isCompleted ?? this.isCompleted,
      content: content ?? this.content,
      description: description ?? this.description,
      due: due ?? this.due,
      duration: duration ?? this.duration,
      id: id ?? this.id,
      labels: labels ?? this.labels,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      parentId: parentId ?? this.parentId,
      url: url ?? this.url,
    );
  }
}
