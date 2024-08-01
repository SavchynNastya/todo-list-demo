import 'package:todolist/core/helpers/types.dart';
import 'package:todolist/features/history/domain/entities/task_item.dart';

abstract class HistoryRepository {
  FutureFailable<List<TaskItem>> getCompletedTaskList();
}
