import 'package:dartz/dartz.dart' as dartz;
import 'package:fimber/fimber.dart';
import 'package:todolist/core/errors/failures.dart';
import 'package:todolist/core/helpers/types.dart';
import 'package:todolist/features/history/domain/entities/task_item.dart';
import 'package:todolist/features/history/domain/repositories/history_repository.dart';
import 'package:todolist/features/history/data/datasource/history_datasource.dart';

class HistoryRepositoryImpl extends HistoryRepository {
  final HistoryDatasource datasource;

  HistoryRepositoryImpl({required this.datasource});

  @override
  FutureFailable<List<TaskItem>> getCompletedTaskList() async {
    try {
      final completedTasks = await datasource.getCompletedTaskList();
      return dartz.Right(completedTasks);
    } catch (e, st) {
      Fimber.e('Error getting completed task list: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }
}
