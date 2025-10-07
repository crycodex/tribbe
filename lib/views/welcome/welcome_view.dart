import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribbe/controllers/theme_notifier.dart';
import 'package:tribbe/config/theme/color_scheme.dart';
import 'package:tribbe/widgets/common/app_header.dart';
import 'package:tribbe/widgets/welcome/welcome_content.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    final isDark = themeState.isDarkMode;
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
  }
}
