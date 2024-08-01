import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/features/settings/presentation/widgets/settings_item_tile.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsItemTile(
          actionName: 'Add a task section',
          onTapAction: () => context.go('/create-section'),
        ),
      ],
    );
  }
}
