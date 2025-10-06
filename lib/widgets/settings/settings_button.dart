import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_native/cupertino_native.dart';
import 'package:tribbe/controllers/system/theme_controller.dart';
import 'package:tribbe/controllers/system/language_controller.dart';
import 'package:tribbe/controllers/system/gender_controller.dart';
import 'package:tribbe/widgets/settings/theme_action_sheet.dart';
import 'package:tribbe/widgets/settings/language_action_sheet.dart';
import 'package:tribbe/widgets/settings/gender_action_sheet.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<ThemeController, LanguageController, GenderController>(
      builder:
          (
            context,
            themeController,
            languageController,
            genderController,
            child,
          ) {
            return CNPopupMenuButton.icon(
              buttonIcon: CNSymbol(
                'gearshape.fill',
                size: 18,
                color: Colors.white,
              ),
              tint: Colors.white,
              items: [
                CNPopupMenuItem(
                  label: 'Tema: ${themeController.themeModeName}',
                  icon: CNSymbol(
                    themeController.isDarkMode ? 'moon.fill' : 'sun.max.fill',
                    size: 18,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                CNPopupMenuItem(
                  label: 'Idioma: ${languageController.languageName}',
                  icon: CNSymbol(
                    'globe',
                    size: 18,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                CNPopupMenuItem(
                  label: 'Género: ${genderController.genderName}',
                  icon: CNSymbol(
                    'person.fill',
                    size: 18,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                const CNPopupMenuDivider(),
              ],
              onSelected: (index) {
                _handleMenuSelection(
                  context,
                  index,
                  themeController,
                  languageController,
                  genderController,
                );
              },
            );
          },
    );
  }

  void _handleMenuSelection(
    BuildContext context,
    int index,
    ThemeController themeController,
    LanguageController languageController,
    GenderController genderController,
  ) {
    switch (index) {
      case 0: // Tema
        _showThemeActionSheet(context, themeController);
        break;
      case 1: // Idioma
        _showLanguageActionSheet(context, languageController);
        break;
      case 2: // Género
        _showGenderActionSheet(context, genderController);
        break;
    }
  }

  void _showThemeActionSheet(
    BuildContext context,
    ThemeController themeController,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ThemeActionSheet(themeController: themeController);
      },
    );
  }

  void _showLanguageActionSheet(
    BuildContext context,
    LanguageController languageController,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return LanguageActionSheet(languageController: languageController);
      },
    );
  }

  void _showGenderActionSheet(
    BuildContext context,
    GenderController genderController,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return GenderActionSheet(genderController: genderController);
      },
    );
  }
}
