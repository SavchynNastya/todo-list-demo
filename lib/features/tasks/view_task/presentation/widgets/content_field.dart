import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class ContentField extends StatefulWidget {
  final TextEditingController contentController;

  const ContentField({super.key, required this.contentController});

  @override
  State<ContentField> createState() => _ContentFieldState();
}

class _ContentFieldState extends State<ContentField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.contentController,
      decoration: InputDecoration(
        labelText: 'Content',
        labelStyle: poppins.w500.lightPink(context),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the task content';
        }
        return null;
      },
    );
  }
}
