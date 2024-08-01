import 'package:equatable/equatable.dart';

class TaskItem extends Equatable {
  final String content;
  final String? metaData;
  final String userId;
  final String taskId;
  final int noteCount;
  final String projectId;
  final String sectionId;
  final DateTime? completedAt;
  final String id;

  const TaskItem({
    required this.content,
    this.metaData,
    required this.userId,
    required this.taskId,
    required this.noteCount,
    required this.projectId,
    required this.sectionId,
    this.completedAt,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'meta_data': metaData,
      'user_id': userId,
      'task_id': taskId,
      'note_count': noteCount,
      'project_id': projectId,
      'section_id': sectionId,
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    content,
    metaData,
    userId,
    taskId,
    noteCount,
    projectId,
    sectionId,
    completedAt,
    id,
  ];
}
