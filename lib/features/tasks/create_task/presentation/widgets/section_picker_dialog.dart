import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';

class SectionPickerDialog extends StatefulWidget {
  final List<Section>? sections;

  const SectionPickerDialog({required this.sections});

  @override
  _SectionPickerDialogState createState() => _SectionPickerDialogState();
}

class _SectionPickerDialogState extends State<SectionPickerDialog> {
  Section? _pickedSection;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick Section', style: poppins.w600.lightPurple(context)),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.sections!.map((section) {
            return RadioListTile<Section>(
              title: Text(
                section.name,
                style: poppins.w500.lightBlue(context),
              ),
              value: section,
              groupValue: _pickedSection,
              onChanged: (Section? value) {
                setState(() {
                  _pickedSection = value;
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
            backgroundColor: Clr.of(context).transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side:
                  BorderSide(color: Clr.of(context).mainLightPurple, width: 2),
            ),
          ),
          onPressed: () {
            context.pop(_pickedSection);
          },
          child: Text(
            'Done',
            style: poppins.w500.lightPink(context),
          ),
        ),
      ],
      backgroundColor: Clr.of(context).lightMilkyBaseColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Clr.of(context).mainLightPink, width: 2),
      ),
    );
  }
}
