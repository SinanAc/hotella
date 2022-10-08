import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/register/number_verify_screen.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/main_title.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: KColors.kThemeGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                child: SizedBox(
                  height: size.height / 3.1,
                  child: Image.asset('assets/images/onboarding.png'),
                ),
              ),
              SizedBox(height: size.height/10),              
              const MainTitle(
                text: 'Welcome !',
                fontSize: 30,
                color: KColors.kThemeYellow,
              ),
              KSizedBox.kHeigh_10,
              SizedBox(
                height: 80,
                width: size.width / 1.2,
                child: const MainTitle(
                  text:
                      'Get in to the largest collection of hotels, resorts, and home stays all over the world with all your favorite destinations',
                  fontSize: 20,
                  color: Colors.white70,
                  weight: FontWeight.normal,
                ),
              ),
              KSizedBox.kHeigh_5,
              ButtonWidget(
                text: 'Get Started',
                onTap: () {
                  PushFunctions.push(context, const NumberVerifyScreen());
                },
                width: size.width / 2.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
