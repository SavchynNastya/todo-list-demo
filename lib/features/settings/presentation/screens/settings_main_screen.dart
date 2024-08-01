import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/widgets/app_bars/app_bar.dart';
import 'package:todolist/core/widgets/colored_safe_area.dart';
import 'package:todolist/core/widgets/system_overlay.dart';
import 'package:todolist/features/settings/presentation/widgets/settings_list.dart';

class SettingsMainScreen extends StatefulWidget {
  const SettingsMainScreen({super.key});

  @override
  State<SettingsMainScreen> createState() => _SettingsMainScreenState();
}

class _SettingsMainScreenState extends State<SettingsMainScreen> {
  @override
  Widget build(BuildContext context) {
    return SystemOverlayWrapper(
      style: SystemUiOverlayStyle.dark,
      child: ColoredSafeArea(
        child: PopScope(
          canPop: false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor:
            Clr
                .of(context)
                .lightMilkyBaseColor,
            appBar: DefaultAppBar(
              pageTitle: 'Settings', onBackButtonTap: () => context.pop(),
            ),
            body: const SettingsList(),
          ),
        ),
      ),
    );
  }
}
