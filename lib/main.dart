import 'package:flutter/material.dart';
import 'package:premio_inn/view/screens/splash/splash_screen.dart';
import 'package:premio_inn/view_model/providers.dart';

void main() {
  runApp(Providers.providers());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
