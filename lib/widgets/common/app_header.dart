import 'package:flutter/material.dart';
import 'package:tribbe/widgets/settings/settings_button.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [SettingsButton()],
    );
  }
}
