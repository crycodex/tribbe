import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//theme
import 'package:tribbe/config/theme/theme_data.dart';
import 'package:tribbe/config/routes/route.dart';
import 'package:tribbe/controllers/theme_notifier.dart';
import 'package:tribbe/controllers/language_notifier.dart';
import 'package:tribbe/core/di/injection_container.dart';
import 'package:tribbe/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupDependencyInjection();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    final languageState = ref.watch(languageNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tribbe',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeState.themeMode,
      locale: languageState.locale,
      home: const AuthWrapper(),
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.welcome,
    );
  }
}
