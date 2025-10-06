import 'package:flutter/material.dart';
import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:provider/provider.dart';
import 'package:tribbe/config/routes/route.dart';
import 'package:tribbe/config/theme/color_scheme.dart';
import 'package:tribbe/controllers/system/theme_controller.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        final isDark = themeController.isDarkMode;
        final primaryColor = isDark
            ? darkColorScheme.primary
            : lightColorScheme.primary;
        final onSurfaceColor = isDark
            ? darkColorScheme.onSurface
            : lightColorScheme.onSurface;
        final onSurfaceVariantColor = isDark
            ? darkColorScheme.onSurfaceVariant
            : lightColorScheme.onSurfaceVariant;

        return CupertinoOnboarding(
          onPressedOnLastPage: () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
          pages: [
            WhatsNewPage(
              title: Text(
                '¿Qué es Tribbe?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: onSurfaceColor,
                ),
              ),
              features: [
                WhatsNewFeature(
                  icon: Icon(
                    Icons.person_outline,
                    size: 32,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Crea tu perfil',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: onSurfaceColor,
                    ),
                  ),
                  description: Text(
                    'Obtén datos personalizados de tus entrenamientos y crea objetivos.',
                    style: TextStyle(
                      fontSize: 16,
                      color: onSurfaceVariantColor,
                    ),
                  ),
                ),
                WhatsNewFeature(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 32,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Gimnasio',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: onSurfaceColor,
                    ),
                  ),
                  description: Text(
                    'Pertenece a tu gimnasio, obtén una reputación, entrenadores, rutinas y más.',
                    style: TextStyle(
                      fontSize: 16,
                      color: onSurfaceVariantColor,
                    ),
                  ),
                ),
                WhatsNewFeature(
                  icon: Icon(
                    Icons.workspace_premium_outlined,
                    size: 32,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Insignias',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: onSurfaceColor,
                    ),
                  ),
                  description: Text(
                    'Crea una racha y comparte tus logros.',
                    style: TextStyle(
                      fontSize: 16,
                      color: onSurfaceVariantColor,
                    ),
                  ),
                ),
                WhatsNewFeature(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    size: 32,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Tiendas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: onSurfaceColor,
                    ),
                  ),
                  description: Text(
                    'Accede a tiendas de suplementos y ropa exclusivos con descuentos únicos.',
                    style: TextStyle(
                      fontSize: 16,
                      color: onSurfaceVariantColor,
                    ),
                  ),
                ),
                WhatsNewFeature(
                  icon: Icon(
                    Icons.people_outline,
                    size: 32,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Social',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: onSurfaceColor,
                    ),
                  ),
                  description: Text(
                    'Haz amigos, incluso compite y mira quien es el más fuerte.',
                    style: TextStyle(
                      fontSize: 16,
                      color: onSurfaceVariantColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
