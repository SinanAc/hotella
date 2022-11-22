import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/register/phone_number_screen.dart';
import 'package:premio_inn/view/screens/register/widgets/text_button.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view/widgets/password_textfield_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view/widgets/text_field_widget.dart';
import 'package:premio_inn/view_model/register/signin_view_model.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signinController = context.read<SigninViewModel>();
    return Scaffold(
      backgroundColor: KColors.kThemeGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Form(
            key: signinController.signInFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleWidget(
                  'Sign in to',
                  color: KColors.kWhiteColor,
                  fontSize: 22,
                ),
                KSizedBox.kHeigh_5,
                TitleWidget(
                  'Hotella',
                  color: KColors.kThemeYellow,
                  fontSize: 30,
                ),
                KSizedBox.kHeigh_15,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: KColors.kWhiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 30, bottom: 25),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          hintText: 'Email / Mobile number',
                          controller: signinController.phoneOrEmailController,
                          validator: signinController.emailValidator,
                        ),
                        KSizedBox.kHeigh_20,
                        PasswordTextFieldWidget(
                          hintText: 'Password',
                          controller: signinController.passwordController,
                          validator: signinController.passwordValidator,
                          signPro: Provider.of<SigninViewModel>(context),
                        ),
                        KSizedBox.kHeigh_30,
                        Selector<SigninViewModel, bool>(
                          selector: ((_, provider) => provider.isLoading),
                          builder: (__, isLoading, _) => isLoading
                              ? const LoadingIndicator()
                              : ButtonWidget(
                                  text: 'Sign in',
                                  onTap: () {
                                    signinController.signInFormKey.currentState
                                        ?.validate();
                                    signinController.onSigninButton();
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                KSizedBox.kHeigh_40,
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: TextButtonWidget(
        text: "Don't have an account?",
        buttonText: 'Register',
        onTap: () {
          signinController.disposes();
          Navigations.pushReplace(const PhoneNumberScreen());
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
