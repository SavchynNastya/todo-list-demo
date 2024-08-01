import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/router.dart';

import 'core/widgets/system_overlay.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer().init();
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return ClrThemeWidget(
          isDarkTheme: false,
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: const TodoListApp(),
          ),
        );
      },
    ),
  );
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemOverlayWrapper(
      style: SystemUiOverlayStyle.light,
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        theme: ThemeData(
          useMaterial3: false,
        ),
      ),
    );
  }
}