import 'package:equatable/equatable.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/due.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/duration.dart';

class Task extends Equatable {
  final String creatorId;
  final DateTime createdAt;
  final String? assigneeId;
  final String? assignerId;
  final int commentCount;
  final bool isCompleted;
  final String content;
  final String? description;
  final Due? due;
  final TaskDuration? duration;
  final String id;
  final List<String>? labels;
  final int? order;
  final int? priority;
  final String? projectId;
  final String? sectionId;
  final String? parentId;
  final String url;

  const Task({
    required this.creatorId,
    required this.createdAt,
    required this.assigneeId,
    required this.assignerId,
    required this.commentCount,
    required this.isCompleted,
    required this.content,
    required this.description,
    required this.due,
    required this.duration,
    required this.id,
    required this.labels,
    required this.order,
    required this.priority,
    required this.projectId,
    required this.sectionId,
    required this.parentId,
    required this.url,
  });

  @override
  List<Object?> get props => [
    creatorId,
    createdAt,
    assigneeId,
    assignerId,
    commentCount,
    isCompleted,
    content,
    description,
    due,
    duration,
    id,
    labels,
    order,
    priority,
    projectId,
    sectionId,
    parentId,
    url,
  ];
}