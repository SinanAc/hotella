import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/register/sign_in_screen.dart';
import 'package:premio_inn/view/screens/register/widgets/text_button.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/single_color_title.dart';
import 'package:premio_inn/view/widgets/text_field_widget.dart';
import 'package:premio_inn/view_model/register/number_verify.dart';
import 'package:provider/provider.dart';

class NumberVerifyScreen extends StatelessWidget {
  const NumberVerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberVerifyController =
        Provider.of<NumVerifyViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: KColors.kThemeGreen,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: numberVerifyController.numVerifyFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SingleColorTitle(
                    text: "Let's Register",
                    color: KColors.kWhiteColor,
                  ),
                  KSizedBox.kHeigh_5,
                  const SingleColorTitle(
                    text: 'Hotella',
                    color: KColors.kThemeYellow,
                  ),
                  KSizedBox.kHeigh_20,
                  Column(
                    children: [
                      TextFieldWidget(
                        hintText: 'Mobile number',
                        controller:
                            numberVerifyController.mobileNumberController,
                        validator: numberVerifyController.numberValidator,
                        keyType: const TextInputType.numberWithOptions(),
                      ),
                      KSizedBox.kHeigh_20,
                      ButtonWidget(
                        text: 'Get OTP',
                        onTap: () {
                          //  numberVerifyController.numVerifyFormKey.currentState!
                          //      .validate();
                          //  numberVerifyController
                          //      .onGetOtpButton(context);
                          numberVerifyController.mobileNumberController.clear();
                           showBottomSheet(
                            context,
                            MediaQuery.of(context).size,
                          );
                          
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: TextButtonWidget(
        text: "Already have an account?",
        buttonText: 'Sign in',
        onTap: () {
          PushFunctions.push(context, const SignInScreen());
          // numberVerifyController.disposes();
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void showBottomSheet(
      BuildContext context, Size size) {
            final numberVerifyController =
        Provider.of<NumVerifyViewModel>(context, listen: false);
    showModalBottomSheet(
      //isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(40),
          height: size.height / 1.1,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              const SingleColorTitle(
                text: 'Verify otp',
                color: KColors.kThemeGreen,
              ),
              KSizedBox.kHeigh_15,
              PinCodeTextField(
                autoDisposeControllers: false,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: numberVerifyController.otpController,
                onChanged: (value) {},
                appContext: context,
              ),
              KSizedBox.kHeigh_15,
              ButtonWidget(
                text: 'Verify',
                onTap: () {
                  log('=========${numberVerifyController.otpController.text}=========');
                  numberVerifyController.otpController.clear();
                  Navigator.pop(context);
                },
                color: KColors.kThemeGreen,
              )
            ]
          ),
        );
      },
    );
  }
}
