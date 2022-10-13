import 'dart:async';
import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view_model/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashController = Provider.of<SplashViewModel>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 2), () {
         splashController.checkLogin(context);
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
