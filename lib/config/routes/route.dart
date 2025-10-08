import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribbe/controllers/auth_controller.dart';
import 'package:tribbe/views/welcome/welcome_view.dart';
import 'package:tribbe/views/welcome/onboarding.dart';
import 'package:tribbe/views/home/home_view.dart';
import 'package:tribbe/views/auth/login_view.dart';
import 'package:tribbe/views/auth/register_view.dart';
import 'package:tribbe/views/auth/forgot_password_view.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeView(),
          settings: settings,
        );

      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingView(),
          settings: settings,
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
          settings: settings,
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
          settings: settings,
        );

      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterView(),
          settings: settings,
        );

      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordView(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const WelcomeView(),
          settings: settings,
        );
    }
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final authController = Get.find<AuthController>();

      // Mostrar loading mientras se verifica el estado
      if (authController.isLoading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      // Si hay un usuario autenticado, mostrar HomeView
      if (authController.isAuthenticated) {
        return const HomeView();
      }

      // Si no hay usuario autenticado, mostrar WelcomeView
      return const WelcomeView();
    });
  }
}
