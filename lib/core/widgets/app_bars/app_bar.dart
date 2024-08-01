import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/widgets/app_bars/custom_app_bar.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final List<Widget>? actions;
  final Function()? onBackButtonTap;

  const DefaultAppBar({
    Key? key,
    required this.pageTitle,
    this.actions,
    this.onBackButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(
      withBorder: false,
      appBarColor: Clr.of(context).lightMilkyBaseColor,
      titleText: pageTitle,
      rightBarButton: IconButton(
        icon: const Icon(CupertinoIcons.settings),
        onPressed: () => context.push('/settings'),
      ),
      actions: actions,
      leftBarButton: onBackButtonTap != null ? IconButton(
        icon: const Icon(CupertinoIcons.chevron_back),
        onPressed: onBackButtonTap,
      ) : null,
    );
  }

  @override
  Size get preferredSize => const Size(375, 44);
}
