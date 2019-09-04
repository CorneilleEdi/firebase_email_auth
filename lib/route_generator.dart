import 'package:email_auth/pages/login_page.dart';
import 'package:email_auth/pages/main_page.dart';
import 'package:email_auth/pages/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/registration':
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case '/main':
        if (args is FirebaseUser) {
          return MaterialPageRoute(
            builder: (_) => MainPage(
              user: args,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
    }
  }
}
