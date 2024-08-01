import 'package:flutter/cupertino.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/widgets/empty_states/default_empty_state.dart';
import 'package:todolist/features/sections_board/presentation/widgets/task_tile.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

class TasksList extends StatelessWidget {
  final List<Task>? tasks;
  final Color? tileColor;
  final String emptyListText;

  const TasksList({
    super.key,
    required this.tasks,
    this.tileColor,
    required this.emptyListText,
  });

  @override
  Widget build(BuildContext context) {
    return tasks!.isNotEmpty
        ? ListView.builder(
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemCount: tasks!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8, top: index == 0 ? 16 : 0),
                child: TaskTile(
                  taskItem: tasks![index],
                  color: tileColor ?? Clr.of(context).lighterLightYellow,
                  borderRadius: CBorderRadius.all8,
                ),
              );
            },
          )
        : DefaultEmptyState(
            emptyText: emptyListText,
          );
  }
}
