import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/paddings.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/features/history/domain/entities/task_item.dart';


class TaskHistoryItem extends StatelessWidget {
  final TaskItem taskHistoryItem;

  const TaskHistoryItem({super.key, required this.taskHistoryItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 350,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Clr.of(context).lighterLightBlue,
            borderRadius: CBorderRadius.all8,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Navigate to task details or another action
              },
              borderRadius: CBorderRadius.all8,
              child: Padding(
                padding: CPaddings.all16,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskHistoryItem.content,
                        style: poppins.w600.s14
                            .copyWith(color: Clr.of(context).darkGray.withOpacity(0.7)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Completed At: ${taskHistoryItem.completedAt != null
                                  ? DateFormat('yyyy-MM-dd HH:mm').format(taskHistoryItem.completedAt!)
                                  : "No Date Available"}",
                              style: poppins.w400.s11.copyWith(
                                color: Clr
                                    .of(context)
                                    .darkGray
                                    .withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
