import 'dart:ui';

import 'package:dartz/dartz.dart' as dartz;
import 'package:fimber/fimber.dart';
import 'package:todolist/core/errors/failures.dart';
import 'package:todolist/core/helpers/types.dart';
import 'package:todolist/features/tasks/create_task/data/datasource/create_task_datasource.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/label.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';
import 'package:todolist/features/tasks/create_task/domain/repositories/create_task_repository.dart';

class CreateTaskRepositoryImpl extends CreateTaskRepository {
  final CreateTaskDatasource datasource;

  CreateTaskRepositoryImpl({
    required this.datasource,
  });

  @override
  FutureFailable<Task> createTask(
    String sectionId,
    String content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  ) async {
    try {
      final createdTask = await datasource.createTask(
        sectionId,
        content,
        description,
        labels,
        priority,
        dueDatetime,
        duration,
        durationUnit,
      );
      return dartz.Right(createdTask);
    } catch (e, st) {
      Fimber.e('Error creating task: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<Label> createLabel(
    String name,
    int? order,
    Color? color,
    bool? isFavorite,
  ) async {
    try {
      final createdLabel = await datasource.createLabel(name, order, color, isFavorite);
      return dartz.Right(createdLabel);
    } catch (e, st) {
      Fimber.e('Error creating label: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }
}
