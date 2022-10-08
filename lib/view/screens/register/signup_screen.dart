import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/screens/register/widgets/or_widget.dart';
import 'package:premio_inn/view/screens/register/widgets/signup_with_google.dart';
import 'package:premio_inn/view/screens/register/widgets/text_button.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view/widgets/password_textfield_widget.dart';
import 'package:premio_inn/view/widgets/single_color_title.dart';
import 'package:premio_inn/view/widgets/text_field_widget.dart';
import 'package:premio_inn/view_model/register/signup_viewmodel.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signupController = Provider.of<SignUpViewModel>(context);
    return Scaffold(
      backgroundColor: KColors.kThemeGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: signupController.signUpKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 18.0),
                  const SingleColorTitle(
                    text: 'Sign up to',
                    color: KColors.kWhiteColor,
                  ),
                  KSizedBox.kHeigh_5,
                  const SingleColorTitle(
                    text: 'Eat 24',
                    color: KColors.kThemeYellow,
                  ),
                  KSizedBox.kHeigh_15,
                  Consumer<SignUpViewModel>(
                    builder: (context, value, child) => Container(
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
                              icon: Icons.visibility,
                              controller: signupController.passwordController,
                              validator: signupController.passwordValidator,
                              signPro: Provider.of<SignUpViewModel>(context,
                                  listen: false),
                            ),
                            KSizedBox.kHeigh_20,
                            PasswordTextFieldWidget(
                              hintText: 'Confirm Password',
                              icon: Icons.visibility,
                              controller:
                                  signupController.confirmPasswordController,
                              validator:
                                  signupController.confirmPasswordValidator,
                              signPro: Provider.of<SignUpViewModel>(context,
                                  listen: false),
                            ),
                            KSizedBox.kHeigh_20,
                            value.isLoading
                                ? const LoadingIndicator()
                                : ButtonWidget(
                                    text: 'Sign up',
                                    onTap: () {
                                      PushFunctions.push(
                                          context, const MainPage());
                                      //signupController.onSignupButton(context);
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  KSizedBox.kHeigh_20,
                  const OrWidget(),
                  KSizedBox.kHeigh_10,
                  const SignUpWithGoogle(),
                  KSizedBox.kHeigh_30,
                  TextButtonWidget(
                    text: "Already have an account?",
                    buttonText: 'Sign in',
                    onTap: () {
                      PushFunctions.pop(context);
                      signupController.disposes();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
