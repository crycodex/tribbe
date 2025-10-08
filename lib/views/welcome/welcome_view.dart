import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribbe/controllers/theme_controller.dart';
import 'package:tribbe/config/theme/color_scheme.dart';
import 'package:tribbe/widgets/common/app_header.dart';
import 'package:tribbe/widgets/welcome/welcome_content.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeController = Get.find<ThemeController>();
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
    });
  }
}
