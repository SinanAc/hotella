import 'dart:async';
import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/view/screens/onboarding/onboarding_started_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 2), () {
        PushFunctions.pushReplace(context, const OnboardingScreen());
      });
    });
    return Scaffold(
      backgroundColor: KColors.kThemeGreen,
      body: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 120,
            )),
    );
  }
}
