import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/widgets/constrained_content.dart';
import 'package:todolist/features/bottom_nav_bar/entities/navigation_item.dart';
import 'package:todolist/features/bottom_nav_bar/presentation/nav_bar_item.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late final List<BottomBarItem> tabs;

  int get _currentIndex =>
      _locationToTabIndex(GoRouterState.of(context).uri.path);

  @override
  void initState() {
    tabs = [
      BottomBarItem(
        path: '/today-tasks',
        labelText: 'Today tasks',
        icon: CupertinoIcons.text_badge_checkmark,
      ),
      BottomBarItem(
        path: '/tasks-board/0',
        labelText: 'Board',
        icon: CupertinoIcons.rectangle_stack,
      ),
      BottomBarItem(
        path: '/due-tasks',
        labelText: 'Overdue Tasks',
        icon: CupertinoIcons.text_badge_xmark,
      ),
      BottomBarItem(
        path: '/history',
        labelText: 'History',
        icon: CupertinoIcons.list_bullet_indent,
      ),
    ];
    super.initState();
  }

  int _locationToTabIndex(String location) {
    final index = tabs.indexWhere((t) => location[location.length - 2] == '/' &&
        location[location.length - 1] != '0'
        ? ('${location.substring(0, (location.length - 1))}0')
        .startsWith(t.path)
        : location.startsWith(t.path));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(String path) {
    final index = _locationToTabIndex(path);
    context.go(tabs[index].path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 100,
          decoration: BoxDecoration(
            color: Clr.of(context).white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 20,
                color: Colors.black.withOpacity(0.2),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedContentWidget(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    tabs.length,
                        (index) => BottomNavBarItem(
                      bottomBarItem: tabs[index],
                      selected: index == _currentIndex,
                      onTap: _onItemTapped,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
