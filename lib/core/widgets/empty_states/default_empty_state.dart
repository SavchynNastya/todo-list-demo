import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/paddings.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class DefaultEmptyState extends StatelessWidget {
  final String emptyText;
  final String? navigateTo;
  final String? routeName;

  const DefaultEmptyState({
    super.key,
    required this.emptyText,
    this.navigateTo,
    this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CPaddings.top80,
      child: SizedBox(
        child: Padding(
          padding: CPaddings.vertical32,
          child: Column(
            children: [
              Text(
                emptyText,
                textAlign: TextAlign.center,
                style:
                    poppins.w400.s18.copyWith(color: Clr.of(context).darkGray),
              ),
              routeName != null && navigateTo != null
                  ? TextButton(
                      onPressed: () => context.push(navigateTo!),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                            Clr.of(context).lighterLightYellow),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Clr.of(context).lighterLightYellow),
                      ),
                      child: Text(
                        routeName!,
                        style: poppins.w400.s12.copyWith(
                          color: Clr.of(context).darkGray,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
