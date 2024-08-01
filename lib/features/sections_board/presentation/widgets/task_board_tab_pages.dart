import 'package:flutter/material.dart';

class TaskBoardTabPages extends StatefulWidget {
  final List<Tab> tabs;
  final TabController tabController;
  final List<Widget> pages;

  const TaskBoardTabPages({
    Key? key,
    required this.tabs,
    required this.tabController,
    required this.pages,
  }) : super(key: key);

  @override
  State<TaskBoardTabPages> createState() => _UserTabPagesState();
}

class _UserTabPagesState extends State<TaskBoardTabPages> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.tabController.index,
      children: List.generate(widget.tabs.length, (index) {
        return Visibility(
          maintainAnimation: true,
          maintainState: true,
          visible: widget.tabController.index == index,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            opacity: widget.tabController.index == index ? 1 : 0,
            child: widget.pages[index],
          ),
        );
      }),
    );
  }
}
