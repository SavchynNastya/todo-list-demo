import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

class TaskTileInfo extends StatelessWidget {
  final Task taskItem;

  const TaskTileInfo({super.key, required this.taskItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          taskItem.content,
          style: poppins.w600.s14
              .copyWith(color: Clr.of(context).darkGray.withOpacity(0.7)),
        ),
        const SizedBox(height: 8),
        Text(
          taskItem.description ?? '',
          style: poppins.w400.s11
              .copyWith(color: Clr.of(context).darkGray.withOpacity(0.7)),
        ),
      ],
    );
  }
}
