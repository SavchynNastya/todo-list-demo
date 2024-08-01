import 'package:flutter/material.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';


class MainButton extends StatelessWidget {
  final Widget titleWidget;
  final VoidCallback? onTap;
  final bool isActive;
  final bool isLoading;

  const MainButton({
    super.key,
    required this.titleWidget,
    required this.onTap,
    required this.isActive,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: CBorderRadius.all8,
        color:
        isActive ? Clr.of(context).mainLightBlue : Clr.of(context).lighterLightBlue,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Clr.of(context).white.withOpacity(0.2),
          borderRadius: CBorderRadius.all8,
          onTap: isActive ? onTap : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Clr.of(context).mainLightPurple,
                  ),
                )
              else
                titleWidget,
            ],
          ),
        ),
      ),
    );
  }
}
