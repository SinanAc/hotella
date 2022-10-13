import 'package:flutter/material.dart';
import 'package:premio_inn/model/register/sign_up/signup_model.dart';
import 'package:premio_inn/model/register/sign_up/signup_response_model.dart';
import 'package:premio_inn/services/register/signup_service.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/url.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpViewModel extends ChangeNotifier {
  final signUpKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  // make text obscure for passwords
  bool _isObscure = true;
  get isObscure => _isObscure;
  set isObscure(value) {
    _isObscure = value;
    notifyListeners();
  }

  // signup method
  void onSignupButton(context, String phoneNum) async {
    if (signUpKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      final obj = SignUpModel(
        name: nameController.text.trim(),
        phone: phoneNum,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      SignUpResponseModel? signUpResponse =
          await SignUpService().signUpRepo(obj);
      if (signUpResponse == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.errorPopUp('No Response'));
        _isLoadingFalse();
        return;
      } else if (signUpResponse.created == true) {
        final pref = await SharedPreferences.getInstance();
        await pref.setBool(Url.isLogggedIn, true);
        PushFunctions.push(context, const MainPage());
        _isLoadingFalse();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.errorPopUp("${signUpResponse.message}"));
        _isLoadingFalse();
        return;
      }
    }
  }

  // text field validation functions
  String? nameValidator(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Please enter your name';
    } else if (fieldContent.length < 4 || fieldContent.length > 15) {
      return 'Name reqiures 4-15 characters';
    }
    return null;
  }

  String? emailValidator(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(fieldContent)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Please enter your password';
    }
    if (fieldContent.length < 6) {
      return 'Requires atleast 6 characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Confirm Password';
    }
    if (fieldContent != passwordController.text) {
      return 'Password Not Match';
    }
    return null;
  }

  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  // to dispose all the variables
  void disposes() {
    signUpKey.currentState!.reset();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _isObscure = true;
    isLoading = false;
    notifyListeners();
  }
}
