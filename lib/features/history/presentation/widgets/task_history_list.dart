import 'package:flutter/cupertino.dart';
import 'package:todolist/core/widgets/empty_states/default_empty_state.dart';
import 'package:todolist/features/history/domain/entities/task_item.dart';
import 'package:todolist/features/history/presentation/widgets/task_history_item.dart';

class TaskHistoryList extends StatelessWidget {
  final List<TaskItem>? taskHistoryItems;

  const TaskHistoryList({super.key, required this.taskHistoryItems});

  @override
  Widget build(BuildContext context) {
    return taskHistoryItems?.length != null
        ? ListView.builder(
      shrinkWrap: false,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      itemCount: taskHistoryItems!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8, top: index == 0 ? 16 : 0),
          child: TaskHistoryItem(
            taskHistoryItem: taskHistoryItems![index],
          ),
        );
      },
    )
        : const DefaultEmptyState(
      emptyText: 'There are no closed tasks.',
    );
  }
}
