import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth_screens.dart';
import 'package:flutter_application_1/screens/sign_in_screen.dart';
import 'package:flutter_application_1/themes/light_mode.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: const SplashScreen(),
    );
  }
}
