import 'package:flutter/material.dart';
import 'package:premio_inn/model/sign_up/signup_model.dart';
import 'package:premio_inn/model/sign_up/signup_response_model.dart';
import 'package:premio_inn/services/signup_service.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/widgets/show_popup.dart';

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
  void onSignupButton(context) async {
    if (signUpKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      final obj = SignUpModel(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          role: "ROLE_USER");
      SignUpResponseModel? signUpResponse =
          await SignUpService().signUpRepo(obj);
      if (signUpResponse == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.popUp('No Response'));
        _isLoadingFalse();
        return;
      } else if (signUpResponse.message == "true") {
        PushFunctions.push(context, const MainPage());
        _isLoadingFalse();
      } else if (signUpResponse.message != "true") {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.popUp("${signUpResponse.message}"));
        _isLoadingFalse();
        return;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.popUp('Something went wrong !!!'));
        _isLoadingFalse();
      }
    }
  }

  String? nameValidator(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Please enter your name';
    }else if(fieldContent.length<4 || fieldContent.length>15){
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
