import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/features/bottom_nav_bar/entities/navigation_item.dart';

class BottomNavBarItem extends StatefulWidget {
  const BottomNavBarItem({
    super.key,
    required this.bottomBarItem,
    this.selected = false,
    this.onTap,
  });

  final BottomBarItem bottomBarItem;
  final bool selected;
  final Function(String path)? onTap;

  @override
  State<BottomNavBarItem> createState() => _BottomNavBarItemState();
}

class _BottomNavBarItemState extends State<BottomNavBarItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          _startAnimation();
          widget.onTap?.call(widget.bottomBarItem.path);
        },
        child: SizedBox(
          width: 55,
          height: 60,
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScaleTransition(
                        scale: _animation.drive(Tween(begin: 1.0, end: 0.8)),
                        child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Icon(
                              widget.bottomBarItem.icon,
                              color: widget.selected
                                  ? Clr.of(context).mainLightPurple
                                  : Clr.of(context).grey,
                            )
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
