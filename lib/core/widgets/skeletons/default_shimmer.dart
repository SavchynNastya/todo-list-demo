import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todolist/core/style/colors/colors.dart';

class DefaultShimmer extends StatelessWidget {
  final Widget child;

  const DefaultShimmer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Clr.of(context).mainLightPink.withOpacity(0.1),
      highlightColor: Clr.of(context).lightMilkyBaseColor.withOpacity(0.1),
      direction: ShimmerDirection.ltr,
      period: const Duration(milliseconds: 1000),
      child: child,
    );
  }
}
