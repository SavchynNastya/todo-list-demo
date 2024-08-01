import 'dart:ui';

import 'package:todolist/core/helpers/types.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/label.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

abstract class CreateTaskRepository {
  FutureFailable<Task> createTask(
    String sectionId,
    String content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  );

  FutureFailable<Label> createLabel(
    String name,
    int? order,
    Color? color,
    bool? isFavorite,
  );
}
