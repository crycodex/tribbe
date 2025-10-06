import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribbe/controllers/auth_controller.dart';
import 'package:tribbe/views/welcome_view.dart';
import 'package:tribbe/views/home/home_view.dart';
import 'package:tribbe/views/auth/login_view.dart';
import 'package:tribbe/views/auth/register_view.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeView(),
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
    return Consumer<AuthController>(
      builder: (context, authController, child) {
        // Mostrar loading mientras se verifica el estado
        if (authController.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Si hay un usuario autenticado, mostrar HomeView
        if (authController.isAuthenticated) {
          return const HomeView();
        }

        // Si no hay usuario autenticado, mostrar WelcomeView
        return const WelcomeView();
      },
    );
  }
}
