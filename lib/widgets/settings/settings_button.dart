import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tribbe/controllers/system/theme_controller.dart';
import 'package:tribbe/controllers/system/language_controller.dart';
import 'package:tribbe/widgets/settings/settings_action_sheet.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeController, LanguageController>(
      builder: (context, themeController, languageController, child) {
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showSettingsActionSheet(
            context,
            themeController,
            languageController,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              CupertinoIcons.settings,
              color: Colors.white,
              size: 24,
            ),
          ),
        );
      },
    );
  }

  void _showSettingsActionSheet(
    BuildContext context,
    ThemeController themeController,
    LanguageController languageController,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SettingsActionSheet(
          themeController: themeController,
          languageController: languageController,
        );
      },
    );
  }
}
