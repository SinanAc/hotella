import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/register/sign_in_screen.dart';
import 'package:premio_inn/view/screens/register/widgets/text_button.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view/widgets/text_field_widget.dart';
import 'package:premio_inn/view_model/register/phone_number.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final numberVerifyController = context.read<PhoneNumberViewModel>();
    return Scaffold(
      key: numberVerifyController.scaffoldKey,
      backgroundColor: KColors.kThemeGreen,
      body: SafeArea(
        child: Form(
          key: numberVerifyController.numVerifyFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleWidget(
                  "Let's Register",
                  color: KColors.kWhiteColor,
                  fontSize: 22,
                ),
                KSizedBox.kHeigh_5,
                TitleWidget(
                  'Hotella',
                  color: KColors.kThemeYellow,
                  fontSize: 30,
                ),
                KSizedBox.kHeigh_20,
                Column(
                  children: [
                    TextFieldWidget(
                      hintText: 'Enter your 10 digit mobile number',
                      controller: numberVerifyController.mobileNumberController,
                      validator: numberVerifyController.phoneNumberValidator,
                      keyType: const TextInputType.numberWithOptions(),
                      inputFormat: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    KSizedBox.kHeigh_20,
                    Selector<PhoneNumberViewModel, bool>(
                      selector: ((_, provider) => provider.isLoading),
                      builder: (__, isLoading, _) => isLoading
                          ? const LoadingIndicator()
                          : ButtonWidget(
                              text: 'Get OTP',
                              onTap: () {
                                numberVerifyController
                                    .numVerifyFormKey.currentState
                                    ?.validate();
                                numberVerifyController.onGetOtpButton();
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
      floatingActionButton: TextButtonWidget(
        text: "Already have an account?",
        buttonText: 'Sign in',
        onTap: () {
          numberVerifyController.disposes();
          Navigations.pushReplace(const SignInScreen());
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
