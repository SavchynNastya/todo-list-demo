import 'package:flutter/material.dart';

class ConstrainedContentWidget extends StatelessWidget {
  final Widget child;

  const ConstrainedContentWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: child,
    );
  }
}
