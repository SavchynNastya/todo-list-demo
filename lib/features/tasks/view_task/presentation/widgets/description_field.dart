import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class DescriptionField extends StatefulWidget {
  final TextEditingController descriptionController;

  const DescriptionField({
    super.key,
    required this.descriptionController,
  });

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.descriptionController,
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: poppins.w500.lightBlue(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Clr.of(context).mainLightPurple,
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
      maxLines: 3,
    );
  }
}
