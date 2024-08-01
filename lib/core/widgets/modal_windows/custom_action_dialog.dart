import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/core/widgets/buttons/border_button.dart';
import 'package:todolist/core/widgets/buttons/main_button.dart';
import 'package:todolist/core/widgets/constrained_content.dart';

class CustomActionDialog extends StatelessWidget {
  final String title;
  final String helpText;
  final String applyButtonText;
  final Function() onApplyButtonTap;
  final bool isLoading;
  final String closeButtonText;
  final Function()? onCloseButtonTap;

  const CustomActionDialog({
    super.key,
    required this.title,
    required this.helpText,
    required this.applyButtonText,
    required this.onApplyButtonTap,
    this.closeButtonText = 'Cancel',
    this.onCloseButtonTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: Clr.of(context).white,
        child: ConstrainedContentWidget(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                title == ''
                    ? const SizedBox()
                    : Text(
                  title,
                  textAlign: TextAlign.center,
                  style: poppins.s18.h12.w400.darkGray(context),
                ),
                SizedBox(height: title == '' ? 0 : 16),
                Text(
                  helpText,
                  textAlign: TextAlign.center,
                  style: poppins.s14.h12.w400.darkGray(context),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: BorderButton(
                        titleWidget: Text(
                          closeButtonText,
                          style:
                          poppins.s16.h15.w600.sp038.darkGray(context),
                        ),
                        onTap: onCloseButtonTap ?? () => context.pop(),
                        backgroundColor: Clr.of(context).white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MainButton(
                        titleWidget: Text(
                          applyButtonText,
                          style: poppins.s16.h15.w600.sp038.darkGray(context),
                        ),
                        onTap: onApplyButtonTap,
                        isActive: true,
                        isLoading: isLoading,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
