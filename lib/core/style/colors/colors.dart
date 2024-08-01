import 'package:flutter/material.dart';
import 'package:todolist/core/style/color_themes/themes.dart';


class ClrThemeWidget extends StatefulWidget {
  const ClrThemeWidget({
    Key? key,
    required this.child,
    required this.isDarkTheme,
  }) : super(key: key);

  final Widget child;
  final bool isDarkTheme;

  @override
  State<ClrThemeWidget> createState() => _ClrThemeWidgetState();
}

class _ClrThemeWidgetState extends State<ClrThemeWidget> {
  late bool isDarkMode;

  @override
  void initState() {
    isDarkMode = widget.isDarkTheme;
    super.initState();
  }

  void changeTheme({required bool isDarkMode}) {
    setState(() => this.isDarkMode = isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Clr(
      isDarkMode: isDarkMode,
      child: widget.child,
    );
  }
}

class Clr extends InheritedWidget {
  const Clr({
    super.key,
    required super.child,
    this.isDarkMode = false,
  });

  final bool isDarkMode;

  static Clr of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Clr>()!;
  }

  static void switchTheme(BuildContext context) {
    final state = context.findAncestorStateOfType<_ClrThemeWidgetState>()!;
    state.changeTheme(isDarkMode: !state.isDarkMode);
  }

  static bool isDarkTheme(BuildContext context) {
    final state = context.findAncestorStateOfType<_ClrThemeWidgetState>()!;
    return state.isDarkMode;
  }

  @override
  bool updateShouldNotify(covariant Clr oldWidget) {
    return oldWidget.isDarkMode != isDarkMode;
  }

  Color get mainLightPink => isDarkMode ? DarkTheme.mainLightPink : LightTheme.mainLightPink;
  Color get mainLightYellow => isDarkMode ? DarkTheme.mainLightYellow : LightTheme.mainLightYellow;
  Color get mainLightGreen => isDarkMode ? DarkTheme.mainLightGreen : LightTheme.mainLightGreen;
  Color get mainLightBlue => isDarkMode ? DarkTheme.mainLightBlue : LightTheme.mainLightBlue;
  Color get mainLightPurple => isDarkMode ? DarkTheme.mainLightPurple : LightTheme.mainLightPurple;

  Color get lightMilkyBaseColor => isDarkMode ? DarkTheme.lightMilkyBaseColor : LightTheme.lightMilkyBaseColor;

  Color get lighterLightPink => isDarkMode ? DarkTheme.lighterLightPink : LightTheme.lighterLightPink;
  Color get lighterLightYellow => isDarkMode ? DarkTheme.lighterLightYellow : LightTheme.lighterLightYellow;
  Color get lighterLightGreen => isDarkMode ? DarkTheme.lighterLightGreen : LightTheme.lighterLightGreen;
  Color get lighterLightBlue => isDarkMode ? DarkTheme.lighterLightBlue : LightTheme.lighterLightBlue;
  Color get lighterLightPurple => isDarkMode ? DarkTheme.lighterLightPurple : LightTheme.lighterLightPurple;

  Color get lightGray => isDarkMode ? DarkTheme.lightGray : LightTheme.lightGray;
  Color get darkGray => isDarkMode ? DarkTheme.darkGray : LightTheme.darkGray;
  Color get white => isDarkMode ? DarkTheme.white : LightTheme.white;
  Color get transparent => isDarkMode ? DarkTheme.transparent : LightTheme.transparent;
  Color get mainBlack => isDarkMode ? DarkTheme.mainBlack : LightTheme.mainBlack;

  // Todoist colors
  Color get berryRed => isDarkMode ? DarkTheme.berryRed : LightTheme.berryRed;
  Color get red => isDarkMode ? DarkTheme.red : LightTheme.red;
  Color get orange => isDarkMode ? DarkTheme.orange : LightTheme.orange;
  Color get yellow => isDarkMode ? DarkTheme.yellow : LightTheme.yellow;
  Color get oliveGreen => isDarkMode ? DarkTheme.oliveGreen : LightTheme.oliveGreen;
  Color get limeGreen => isDarkMode ? DarkTheme.limeGreen : LightTheme.limeGreen;
  Color get green => isDarkMode ? DarkTheme.green : LightTheme.green;
  Color get mintGreen => isDarkMode ? DarkTheme.mintGreen : LightTheme.mintGreen;
  Color get teal => isDarkMode ? DarkTheme.teal : LightTheme.teal;
  Color get skyBlue => isDarkMode ? DarkTheme.skyBlue : LightTheme.skyBlue;
  Color get lightBlue => isDarkMode ? DarkTheme.lightBlue : LightTheme.lightBlue;
  Color get blue => isDarkMode ? DarkTheme.blue : LightTheme.blue;
  Color get grape => isDarkMode ? DarkTheme.grape : LightTheme.grape;
  Color get violet => isDarkMode ? DarkTheme.violet : LightTheme.violet;
  Color get lavender => isDarkMode ? DarkTheme.lavender : LightTheme.lavender;
  Color get magenta => isDarkMode ? DarkTheme.magenta : LightTheme.magenta;
  Color get salmon => isDarkMode ? DarkTheme.salmon : LightTheme.salmon;
  Color get charcoal => isDarkMode ? DarkTheme.charcoal : LightTheme.charcoal;
  Color get grey => isDarkMode ? DarkTheme.grey : LightTheme.grey;
  Color get taupe => isDarkMode ? DarkTheme.taupe : LightTheme.taupe;
}
