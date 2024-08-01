import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';


class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color? color;

  const ColoredSafeArea({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Clr.of(context).lightMilkyBaseColor.withOpacity(0.6),
      child: SafeArea(
        top: true,
        bottom: false,
        child: child,
      ),
    );
  }
}
