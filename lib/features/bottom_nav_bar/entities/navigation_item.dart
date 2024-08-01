import 'package:flutter/cupertino.dart';

class BottomBarItem {
  BottomBarItem({
    required this.path,
    required this.labelText,
    required this.icon,
  });

  final String path;
  final String labelText;
  final IconData icon;
}
