import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tribbe/config/theme/theme_data.dart';
import 'package:tribbe/config/routes/route.dart';
import 'package:tribbe/controllers/theme_controller.dart';
import 'package:tribbe/controllers/language_controller.dart';
import 'package:tribbe/controllers/gender_controller.dart';
import 'package:tribbe/controllers/auth_controller.dart';
import 'package:tribbe/controllers/user_profile_controller.dart';
import 'package:tribbe/core/di/injection_container.dart';
import 'package:tribbe/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupDependencyInjection();
  initializeControllers();
  runApp(const MyApp());
}

void initializeControllers() {
  Get.put(ThemeController());
  Get.put(LanguageController());
  Get.put(GenderController());
  Get.put(AuthController());
  Get.put(UserProfileController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final languageController = Get.find<LanguageController>();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tribbe',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeController.themeMode,
        locale: languageController.locale,
        home: const AuthWrapper(),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.welcome,
      ),
    );
  }
}
