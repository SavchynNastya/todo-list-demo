import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:todolist/features/history/data/models/task_item_model.dart';
import 'package:todolist/features/history/domain/entities/task_item.dart';

abstract class HistoryDatasource {
  Future<List<TaskItem>> getCompletedTaskList();
}


class HistoryDatasourceImpl extends HistoryDatasource {
  HistoryDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<TaskItem>> getCompletedTaskList() async {
    try {
      final response = await dio.get('/sync/v9/completed/get_all');
      final List<dynamic> taskItemsJson = response.data['items'];
      return taskItemsJson.map((json) => TaskItemModel.fromJson(json)).toList();
    } catch (e, st) {
      Fimber.e('Error getting completed tasks history: $e', stacktrace: st);
      throw Exception('Failed to get completed tasks history');
    }
  }
}
