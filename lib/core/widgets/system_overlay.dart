import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemOverlayWrapper extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle style;

  const SystemOverlayWrapper({
    super.key,
    required this.child,
    this.style = SystemUiOverlayStyle.light,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: style,
      child: child,
    );
  }
}
