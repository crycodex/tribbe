import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cupertino_native/cupertino_native.dart';
import 'package:tribbe/controllers/theme_controller.dart';
import 'package:tribbe/controllers/language_controller.dart';
import 'package:tribbe/controllers/gender_controller.dart';
import 'package:tribbe/widgets/settings/theme_action_sheet.dart';
import 'package:tribbe/widgets/settings/language_action_sheet.dart';
import 'package:tribbe/widgets/settings/gender_action_sheet.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeController = Get.find<ThemeController>();
      final languageController = Get.find<LanguageController>();
      final genderController = Get.find<GenderController>();

      return CNPopupMenuButton.icon(
        buttonIcon: CNSymbol('gearshape.fill', size: 18, color: Colors.white),
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
            label: 'Género: ${genderController.gender}',
            icon: CNSymbol(
              'person.fill',
              size: 18,
              color: CupertinoColors.activeBlue,
            ),
          ),
          const CNPopupMenuDivider(),
        ],
        onSelected: (index) {
          _handleMenuSelection(context, index);
        },
      );
    });
  }

  void _handleMenuSelection(BuildContext context, int index) {
    switch (index) {
      case 0: // Tema
        _showThemeActionSheet(context);
        break;
      case 1: // Idioma
        _showLanguageActionSheet(context);
        break;
      case 2: // Género
        _showGenderActionSheet(context);
        break;
    }
  }

  void _showThemeActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return const ThemeActionSheet();
      },
    );
  }

  void _showLanguageActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return const LanguageActionSheet();
      },
    );
  }

  void _showGenderActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return const GenderActionSheet();
      },
    );
  }
}
