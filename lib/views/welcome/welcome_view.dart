import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribbe/controllers/system/theme_controller.dart';
import 'package:tribbe/controllers/system/language_controller.dart';
import 'package:tribbe/config/theme/color_scheme.dart';
import 'package:tribbe/widgets/common/app_header.dart';
import 'package:tribbe/widgets/welcome/welcome_content.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeController, LanguageController>(
      builder: (context, themeController, languageController, child) {
        final isDark = themeController.isDarkMode;
        final primaryColor = isDark
            ? darkColorScheme.primary
            : lightColorScheme.primary;

        return Scaffold(
          backgroundColor: primaryColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: const [
                  AppHeader(),
                  Expanded(child: WelcomeContent()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
