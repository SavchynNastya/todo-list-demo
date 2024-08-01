import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class CustomTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController tabController;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return Colors.transparent;
          }),
      indicatorColor: Clr.of(context).mainLightPurple,
      unselectedLabelStyle: poppins.w600.s12.h12,
      unselectedLabelColor: Clr.of(context).lighterLightPurple,
      labelColor: Clr.of(context).mainLightPurple,
      labelStyle: poppins.w600.s12.h12,
      tabs: tabs,
    );
  }
}