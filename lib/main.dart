import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
//theme
import 'package:tribbe/config/theme/theme_data.dart';
import 'package:tribbe/config/routes/route.dart';
import 'package:tribbe/controllers/auth_controller.dart';
import 'package:tribbe/controllers/home_controller.dart';
import 'package:tribbe/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tribbe',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const AuthWrapper(),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.welcome,
      ),
    );
  }
}
