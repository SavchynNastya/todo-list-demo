import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class TimePicker extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;
  final TextEditingController dueTimeController;

  const TimePicker({
    super.key,
    required this.onDateTimeChanged,
    required this.dueTimeController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: dueTimeController,
      decoration: InputDecoration(
        labelText: 'Due Time',
        labelStyle: poppins.w500.lightPink(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Clr.of(context).mainLightBlue,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Clr.of(context).mainLightPink,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Clr.of(context).mainLightYellow.withOpacity(0.2),
      ),
      readOnly: true,
      onTap: () async {
        showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
            height: 250,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: onDateTimeChanged,
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    'Done',
                    style: poppins.w500.lightPink(context),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
