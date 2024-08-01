import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';

class CreateTaskFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CreateTaskFloatingActionButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Clr.of(context).lighterLightPurple,
      tooltip: 'Create Task',
      elevation: 6.0,
      child: const Icon(Icons.add),
    );
  }
}
