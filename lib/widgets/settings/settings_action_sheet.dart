import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tribbe/controllers/system/theme_controller.dart';
import 'package:tribbe/controllers/system/language_controller.dart';
import 'package:tribbe/widgets/settings/theme_action_sheet.dart';
import 'package:tribbe/widgets/settings/language_action_sheet.dart';

class SettingsActionSheet extends StatelessWidget {
  final ThemeController themeController;
  final LanguageController languageController;

  const SettingsActionSheet({
    super.key,
    required this.themeController,
    required this.languageController,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Configuración'),
      message: const Text('Selecciona una opción'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            _showThemeActionSheet(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                themeController.isDarkMode
                    ? CupertinoIcons.moon_fill
                    : CupertinoIcons.sun_max_fill,
                color: CupertinoColors.activeBlue,
              ),
              const SizedBox(width: 8),
              Text('Tema: ${themeController.themeModeName}'),
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            _showLanguageActionSheet(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                languageController.languageFlag,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),
              Text('Idioma: ${languageController.languageName}'),
            ],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancelar'),
      ),
    );
  }

  void _showThemeActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ThemeActionSheet(themeController: themeController);
      },
    );
  }

  void _showLanguageActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return LanguageActionSheet(languageController: languageController);
      },
    );
  }
}
