import 'package:flutter/material.dart';
import 'package:gradproject/auth/login/login_screen.dart';

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
      initialRoute: LoginScreen.RouteName,
      routes: {
        LoginScreen.RouteName : (context)=>LoginScreen(),
      },// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
