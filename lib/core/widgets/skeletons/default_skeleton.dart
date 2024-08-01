import 'package:flutter/material.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/paddings.dart';
import 'package:todolist/core/widgets/skeletons/default_shimmer.dart';

class DefaultSkeletonWidget extends StatelessWidget {
  final double? width;

  const DefaultSkeletonWidget({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CPaddings.all16,
      child: Container(
        width: width ?? 380,
        decoration: BoxDecoration(
          color: Clr.of(context).lightMilkyBaseColor,
          borderRadius: CBorderRadius.all8,
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultShimmer(
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.88),
                      color: Clr.of(context).grey),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 189,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultShimmer(
                      child: Container(
                        width: 60,
                        height: 16,
                        decoration: BoxDecoration(
                            borderRadius: CBorderRadius.all2,
                            color: Clr.of(context).grey),
                      ),
                    ),
                    const SizedBox(height: 4),
                    DefaultShimmer(
                      child: Container(
                        width: 100,
                        height: 15,
                        decoration: BoxDecoration(
                            borderRadius: CBorderRadius.all2,
                            color: Clr.of(context).grey),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultShimmer(
                      child: Container(
                        width: 64,
                        height: 12,
                        decoration: BoxDecoration(
                            borderRadius: CBorderRadius.all2,
                            color: Clr.of(context).grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
