
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class LabelPickerDialog extends StatefulWidget {
  final List<String>? availableLabels;

  const LabelPickerDialog({required this.availableLabels});

  @override
  _LabelPickerDialogState createState() => _LabelPickerDialogState();
}

class _LabelPickerDialogState extends State<LabelPickerDialog> {
  List<String> _pickedLabels = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick Labels', style: poppins.w600.lightPurple(context)),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.availableLabels!.map((label) {
            return CheckboxListTile(
              title: Text(label, style: poppins.w500.lightBlue(context)),
              value: _pickedLabels.contains(label),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _pickedLabels.add(label);
                  } else {
                    _pickedLabels.remove(label);
                  }
                });
              },
              activeColor: Clr.of(context).mainLightGreen,
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Clr.of(context).mainLightBlue.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Clr.of(context).mainLightPurple, width: 2),
            ),
          ),
          onPressed: () {
            Navigator.pop(context, _pickedLabels);
          },
          child: const Text('Done', style: TextStyle(color: Colors.white)),
        ),
      ],
      backgroundColor: Clr.of(context).mainLightYellow.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Clr.of(context).mainLightPink, width: 2),
      ),
    );
  }
}
