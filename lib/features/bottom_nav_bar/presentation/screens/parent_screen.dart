
import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/features/bottom_nav_bar/presentation/nav_bar.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_cubit.dart';
import 'package:todolist/injection_container.dart';

class BottomNavBarParentScreen extends StatefulWidget {
  final Widget child;

  const BottomNavBarParentScreen({
    super.key,
    required this.child,
  });

  @override
  State<BottomNavBarParentScreen> createState() =>
      _BottomNavBarParentScreenState();
}

class _BottomNavBarParentScreenState extends State<BottomNavBarParentScreen> {
  final SectionCubit _sectionCubit = sl<SectionCubit>();

  @override
  void initState(){
    super.initState();

    _sectionCubit.getSectionsList();
    _sectionCubit.getTasksList(null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Clr.of(context).white,
        body: widget.child,
        bottomNavigationBar: const BottomNavBar(),
    );
  }
}
