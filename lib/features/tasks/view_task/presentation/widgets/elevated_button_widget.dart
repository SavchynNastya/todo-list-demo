import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/paddings.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final void Function()? onPressed;
  final Widget child;

  const ElevatedButtonWidget({
    super.key,
    required this.child,
    this. color,
    this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding ?? CPaddings.vertical16,
        backgroundColor: color ?? Clr.of(context).lighterLightPink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
