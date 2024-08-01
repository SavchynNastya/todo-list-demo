import 'package:flutter/material.dart';
import 'package:todolist/core/widgets/skeletons/default_skeleton.dart';

class DefaultSkeletonList extends StatelessWidget {
  const DefaultSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
      const NeverScrollableScrollPhysics(),
      itemCount: 15,
      itemBuilder: (context, index) {
        return const DefaultSkeletonWidget();
      },
    );
  }
}
