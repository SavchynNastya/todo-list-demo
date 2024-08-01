import 'package:flutter/cupertino.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class CollapsedCommentsPanel extends StatelessWidget {
  const CollapsedCommentsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Clr.of(context).lighterLightBlue,
        borderRadius: CBorderRadius.top16,
      ),
      child: Center(
        child: Text(
          'Slide up to add comments',
          style: poppins.w400.s16.darkGray(context),
        ),
      ),
    );
  }
}
