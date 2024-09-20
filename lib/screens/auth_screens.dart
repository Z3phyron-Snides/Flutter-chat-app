import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/sign_in_screen.dart';
import 'package:flutter_application_1/screens/sign_up_screen.dart';

class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});

  @override
  _AuthScreensState createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  bool showLoginPage = true;

  void togglepages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return SignInScreen(
        onTap: togglepages,
      );
    } else {
      return SignUpScreen(
        onTap: togglepages,
      );
    }
  }
}
