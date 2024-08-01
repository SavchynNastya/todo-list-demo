import 'package:flutter/material.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/paddings.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/core/utils/extensions.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Clr.of(context).lighterLightBlue,
      elevation: 2,
      margin: CPaddings.v8h12,
      shape: const RoundedRectangleBorder(
        borderRadius: CBorderRadius.all12,
      ),
      child: ListTile(
        contentPadding: CPaddings.all16,
        title: Text(
          comment.content,
          style: poppins.w500.s16.darkGray(context),
        ),
        trailing: Text(
          comment.postedAt.toDateAndTimeFormat(),
          style: poppins.w400.s14.darkGray(context),
        ),
      ),
    );
  }
}
