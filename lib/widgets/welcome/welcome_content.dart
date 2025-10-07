import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribbe/controllers/theme_notifier.dart';
import 'package:tribbe/config/theme/color_scheme.dart';
import 'package:tribbe/config/routes/route.dart';

class WelcomeContent extends ConsumerWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    final isDark = themeState.isDarkMode;
    final primaryColor = isDark
        ? darkColorScheme.primary
        : lightColorScheme.primary;
    final secondaryColor = isDark
        ? darkColorScheme.secondary
        : lightColorScheme.secondary;
    final onPrimaryColor = isDark
        ? darkColorScheme.onPrimary
        : lightColorScheme.onPrimary;

    return Column(
      children: [
        const Spacer(flex: 1),

        // Texto principal arriba
        const WelcomeTitle(),

        const Spacer(flex: 1),

        // Personaje más grande que se superpone al texto
        const WelcomeCharacter(),

        const Spacer(flex: 2),

        // Botón de acción
        WelcomeActionButton(
          isDark: isDark,
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          onPrimaryColor: onPrimaryColor,
        ),

        const SizedBox(height: 32),
      ],
    );
  }
}

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Encuentra\ntu rutina',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 72,
        height: 1.1,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class WelcomeCharacter extends StatelessWidget {
  const WelcomeCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/character/men/welcome.png',
        fit: BoxFit.contain,
        width: 400,
        height: 400,
      ),
    );
  }
}

class WelcomeActionButton extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Color onPrimaryColor;

  final bool isDark;

  const WelcomeActionButton({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onPrimaryColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.onboarding);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enfócate en ti mismo',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward, color: onPrimaryColor, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
