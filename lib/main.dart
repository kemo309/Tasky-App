import 'package:firebase_core/firebase_core.dart';
import 'package:tasky_app/features/auth/screens/home_screen.dart';
import 'package:tasky_app/features/auth/screens/onbording.dart';
import 'package:tasky_app/features/auth/screens/register_screen.dart';
import 'package:tasky_app/features/auth/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/features/auth/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        Onboarding.routeName: (context) => Onboarding(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
