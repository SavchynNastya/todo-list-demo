import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:todolist/features/tasks/create_task/data/models/label_model.dart';
import 'package:todolist/features/tasks/create_task/data/models/task_model.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/label.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

abstract class CreateTaskDatasource {
  Future<Task> createTask(
    String sectionId,
    String content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  );

  Future<Label> createLabel(
    String name,
    int? order,
    Color? color,
    bool? isFavorite,
  );
}

class CreateTaskDatasourceImpl extends CreateTaskDatasource {
  CreateTaskDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<Task> createTask(
    String sectionId,
    String content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  ) async {
    final Map<String, dynamic> formDataMap = {
      'section_id': sectionId,
      'content': content,
    };

    if (description != null) {
      formDataMap['description'] = description;
    }
    if (labels != null) {
      formDataMap['labels'] = labels;
    }
    if (priority != null) {
      formDataMap['priority'] = priority;
    }
    if (dueDatetime != null) {
      formDataMap['due_datetime'] = dueDatetime;
    }
    if (duration != null) {
      formDataMap['duration'] = duration;
    }
    if (durationUnit != null) {
      formDataMap['duration_unit'] = durationUnit;
    }

    FormData formData = FormData.fromMap(formDataMap);

    try {
      final response = await dio.post(
        '/rest/v2/tasks',
        data: formData,
      );
      return TaskModel.fromJson(response.data);
    } catch (e, st) {
      Fimber.e('Error creating task: $e', stacktrace: st);
      throw Exception('Failed to create task');
    }
  }

  @override
  Future<Label> createLabel(
    String name,
    int? order,
    Color? color,
    bool? isFavorite,
  ) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'order': order,
      'is_favorite': isFavorite
    });
    try {
      final response = await dio.post(
        '/rest/v2/labels',
        data: formData,
      );
      return LabelModel.fromJson(response.data) as Label; // hz
    } catch (e, st) {
      Fimber.e('Error creating label: $e', stacktrace: st);
      throw Exception('Failed to create label');
    }
  }
}
