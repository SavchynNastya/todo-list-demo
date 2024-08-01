import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? rightBarButton;
  final Widget? leftBarButton;
  final String? titleText;
  final Widget? titleWidget;
  final Function()? onTap;
  final Color? appBarColor;
  final bool withBorder;
  final double leftPadding;
  final double rightPadding;
  final double height;
  final List<Widget>? actions;

  const CustomAppBarWidget({
    Key? key,
    this.rightBarButton,
    this.leftBarButton,
    this.titleText,
    this.titleWidget,
    this.onTap,
    this.appBarColor,
    this.withBorder = true,
    this.leftPadding = 16,
    this.rightPadding = 16,
    this.height = 48,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: appBarColor ?? Clr.of(context).white,
        border: withBorder
            ? Border(
                bottom: BorderSide(
                  color: Clr.of(context).grey,
                  width: 1,
                ),
              )
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          leftBarButton != null
              ? Positioned.fill(
                  left: leftPadding,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: leftBarButton,
                  ),
                )
              : const SizedBox(),
          titleText != null
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: Text(
                      titleText!,
                      textAlign: TextAlign.center,
                      style: poppins.s17.h13.w600.darkGray(context).copyWith(
                            letterSpacing: -0.41,
                          ),
                    ),
                  ),
                )
              : const SizedBox(),
          titleWidget != null && titleText == null
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: titleWidget,
                  ),
                )
              : const SizedBox(),
          if (rightBarButton != null || (actions != null && actions!.isNotEmpty))
            Positioned.fill(
              right: rightPadding,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (actions != null) ...actions!,
                    if (rightBarButton != null) rightBarButton!,
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 48);
}
