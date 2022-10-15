import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/register/sign_in_screen.dart';
import 'package:premio_inn/view/screens/register/widgets/text_button.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view/widgets/sub_title.dart';
import 'package:premio_inn/view/widgets/text_field_widget.dart';
import 'package:premio_inn/view_model/register/phone_number.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final numberVerifyController =
        Provider.of<PhoneNumberViewModel>(context, listen: false);
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
                  const TitleWidget(
                    text: "Let's Register",
                    color: KColors.kWhiteColor,
                  ),
                  KSizedBox.kHeigh_5,
                  const TitleWidget(
                    text: 'Hotella',
                    color: KColors.kThemeYellow,
                  ),
                  KSizedBox.kHeigh_20,
                  Column(
                    children: [
                      TextFieldWidget(
                        hintText: 'Enter your 10 digit mobile number',
                        controller:
                            numberVerifyController.mobileNumberController,
                        validator: numberVerifyController.phoneNumberValidator,
                        keyType: const TextInputType.numberWithOptions(),
                      ),
                      KSizedBox.kHeigh_20,
                      Consumer<PhoneNumberViewModel>(
                        builder: (context, value, _) => value.isLoading
                            ? const LoadingIndicator()
                            : ButtonWidget(
                                text: 'Get OTP',
                                onTap: () {
                                  numberVerifyController
                                      .numVerifyFormKey.currentState!
                                      .validate();
                                  numberVerifyController
                                      .onGetOtpButton(context);
                                },
                              ),
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
          numberVerifyController.disposes();
          PushFunctions.push(context, const SignInScreen());
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
