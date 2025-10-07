import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupertino_native/cupertino_native.dart';
import 'package:tribbe/controllers/theme_notifier.dart';
import 'package:tribbe/controllers/language_notifier.dart';
import 'package:tribbe/controllers/gender_notifier.dart';
import 'package:tribbe/widgets/settings/theme_action_sheet.dart';
import 'package:tribbe/widgets/settings/language_action_sheet.dart';
import 'package:tribbe/widgets/settings/gender_action_sheet.dart';

class SettingsButton extends ConsumerWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    final languageState = ref.watch(languageNotifierProvider);
    final genderState = ref.watch(genderNotifierProvider);

    return CNPopupMenuButton.icon(
      buttonIcon: CNSymbol('gearshape.fill', size: 18, color: Colors.white),
      tint: Colors.white,
      items: [
        CNPopupMenuItem(
          label: 'Tema: ${themeState.themeModeName}',
          icon: CNSymbol(
            themeState.isDarkMode ? 'moon.fill' : 'sun.max.fill',
            size: 18,
            color: CupertinoColors.activeBlue,
          ),
        ),
        CNPopupMenuItem(
          label: 'Idioma: ${languageState.languageName}',
          icon: CNSymbol('globe', size: 18, color: CupertinoColors.activeBlue),
        ),
        CNPopupMenuItem(
          label: 'Género: ${genderState.gender}',
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
