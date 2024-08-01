import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class DueDatePicker extends StatefulWidget {
  final TextEditingController dueDateController;
  final void Function() onPicked;

  const DueDatePicker({super.key, required this.dueDateController, required this.onPicked,});

  @override
  State<DueDatePicker> createState() => _DueDatePickerState();
}

class _DueDatePickerState extends State<DueDatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dueDateController,
      decoration: InputDecoration(
        labelText: 'Due Date',
        labelStyle: poppins.w500.lightPurple(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Clr.of(context).mainLightGreen,
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
        fillColor: Clr.of(context).lighterLightYellow.withOpacity(0.2),
      ),
      readOnly: true,
      onTap: () => _selectDueDate(context),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Clr.of(context).lighterLightPink.withOpacity(0.8),
              onPrimary: Clr.of(context).mainBlack,
              onSurface: Clr.of(context).mainBlack,
            ),
            dialogBackgroundColor: Clr.of(context).lightMilkyBaseColor,
            textTheme: TextTheme(
              headlineMedium: poppins.w500.mainBlack(context),
              titleMedium: poppins.w500.mainBlack(context),
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              colorScheme: ColorScheme.light(
                primary: Clr.of(context).mainLightGreen,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              filled: true,
              fillColor: Clr.of(context)
                  .lighterLightPurple
                  .withOpacity(0.3), // Light purple
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      widget.onPicked();
    }
  }
}
