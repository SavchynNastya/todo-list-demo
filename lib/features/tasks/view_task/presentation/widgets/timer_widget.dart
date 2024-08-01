import 'package:flutter/cupertino.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/elevated_button_widget.dart';

class TimerWidget extends StatelessWidget {
  final Duration elapsedTime;
  final void Function() startTimer;
  final void Function() stopTimer;

  const TimerWidget({
    super.key,
    required this.elapsedTime,
    required this.startTimer,
    required this.stopTimer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButtonWidget(
          onPressed: startTimer,
          child: Text(
            'Start',
            style: poppins.w500.darkGray(context),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButtonWidget(
          onPressed: stopTimer,
          child: Text(
            'Stop',
            style: poppins.w500.darkGray(context),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          elapsedTime.toString().split('.').first.padLeft(8, "0"),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
