import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view/widgets/password_textfield_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view/widgets/text_field_widget.dart';
import 'package:premio_inn/view_model/register/signup_viewmodel.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    final signupController = context.read<SignUpViewModel>();
    return Scaffold(
      backgroundColor: KColors.kThemeGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: signupController.signUpKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleWidget(
                      'Sign up to',
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
                            left: 15, right: 15, top: 30, bottom: 20),
                        child: Column(
                          children: [
                            TextFieldWidget(
                              hintText: 'Name',
                              controller: signupController.nameController,
                              validator: signupController.nameValidator,
                            ),
                            KSizedBox.kHeigh_20,
                            TextFieldWidget(
                              hintText: 'Email ID',
                              controller: signupController.emailController,
                              validator: signupController.emailValidator,
                            ),
                            KSizedBox.kHeigh_20,
                            PasswordTextFieldWidget(
                              hintText: 'Password',
                              controller: signupController.passwordController,
                              validator: signupController.passwordValidator,
                              signPro: Provider.of<SignUpViewModel>(context),
                            ),
                            KSizedBox.kHeigh_20,
                            PasswordTextFieldWidget(
                              hintText: 'Confirm Password',
                              controller:
                                  signupController.confirmPasswordController,
                              validator:
                                  signupController.confirmPasswordValidator,
                              signPro: Provider.of<SignUpViewModel>(context),
                            ),
                            KSizedBox.kHeigh_20,
                            Selector<SignUpViewModel, bool>(
                              selector: ((_, provider) => provider.isLoading),
                              builder: (__, isLoading, _) => isLoading
                                  ? const LoadingIndicator()
                                  : ButtonWidget(
                                      text: 'Sign up',
                                      onTap: () {
                                        signupController.signUpKey.currentState
                                            ?.validate();
                                        signupController
                                            .onSignupButton(phoneNumber);
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    KSizedBox.kHeigh_50,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
