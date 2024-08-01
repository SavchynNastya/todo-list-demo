import 'package:flutter/material.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';


class BorderButton extends StatelessWidget {
  final Widget titleWidget;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const BorderButton({
    super.key,
    required this.titleWidget,
    required this.onTap,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: CBorderRadius.all8,
        border: Border.all(
          color: Clr.of(context).mainLightPink,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Clr.of(context).lighterLightPink.withOpacity(0.2),
          borderRadius: CBorderRadius.all8,
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleWidget,
            ],
          ),
        ),
      ),
    );
  }
}
