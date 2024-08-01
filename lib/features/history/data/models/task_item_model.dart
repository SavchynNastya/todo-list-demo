import 'package:todolist/features/history/domain/entities/task_item.dart';

class TaskItemModel extends TaskItem {
  const TaskItemModel({
    required String content,
    String? metaData,
    required String userId,
    required String taskId,
    required int noteCount,
    required String projectId,
    required String sectionId,
    DateTime? completedAt,
    required String id,
  }) : super(
    content: content,
    metaData: metaData,
    userId: userId,
    taskId: taskId,
    noteCount: noteCount,
    projectId: projectId,
    sectionId: sectionId,
    completedAt: completedAt,
    id: id,
  );

  factory TaskItemModel.fromJson(Map<String, dynamic> json) {
    return TaskItemModel(
      content: json['content'],
      metaData: json['meta_data'],
      userId: json['user_id'],
      taskId: json['task_id'],
      noteCount: json['note_count'],
      projectId: json['project_id'],
      sectionId: json['section_id'],
      completedAt: json['completed_at'] != null ? DateTime.parse(json['completed_at']) : null,
      id: json['id'],
    );
  }
}
