import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/paddings.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/core/utils/extensions.dart';
import 'package:todolist/features/sections_board/presentation/widgets/taks_tile_info.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

class TaskTile extends StatelessWidget {
  final Task taskItem;
  final BorderRadius? borderRadius;
  final Color color;

  const TaskTile({
    required this.taskItem,
    required this.color,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 350, // Set the maximum width to 350 pixels
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius ?? CBorderRadius.all8,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.push('/tasks/${taskItem.id}'),
              borderRadius: borderRadius ?? CBorderRadius.all8,
              child: Padding(
                padding: CPaddings.all16,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskTileInfo(
                        taskItem: taskItem,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              taskItem.createdAt.toDateAndTimeFormat(),
                              style: poppins.w400.s11.copyWith(
                                color: Clr
                                    .of(context)
                                    .darkGray
                                    .withOpacity(0.7),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(10, 5),
                              child: Icon(
                                CupertinoIcons.chevron_right,
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
