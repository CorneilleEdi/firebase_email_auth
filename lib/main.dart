import 'package:email_auth/pages/login_page.dart';
import 'package:email_auth/pages/main_page.dart';
import 'package:email_auth/pages/registration_page.dart';
import 'package:email_auth/route_generator.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Email Auth',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0XFF6D3FFF),
        accentColor: Color(0XFF233C63),
        fontFamily: 'Nunito',
        brightness: Brightness.light,
        buttonTheme: ButtonThemeData(),
      ),

      // Generate dNamed Routes
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
