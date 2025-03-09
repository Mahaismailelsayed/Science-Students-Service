import 'package:flutter/material.dart';
import 'package:gradproject/auth/global_password.dart';
import 'package:gradproject/auth/login/login_screen.dart';
import 'package:gradproject/auth/register/register_screen.dart';

import 'gpa_screen.dart';

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
      initialRoute: GlobalPassword.RouteName,
      routes: {
        LoginScreen.RouteName : (context)=>LoginScreen(),
        GpaScreen.RouteName : (context)=>GpaScreen(),
        GlobalPassword.RouteName : (context)=>GlobalPassword(),
        RegisterScreen.RouteName : (context)=>RegisterScreen(),
      },// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
