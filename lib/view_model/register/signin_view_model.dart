import 'package:flutter/material.dart';
import 'package:premio_inn/model/sign_in/sign_in_model.dart';
import 'package:premio_inn/model/sign_in/signin_response_model.dart';
import 'package:premio_inn/services/sign_in_service.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/widgets/show_popup.dart';


class SigninViewModel extends ChangeNotifier {
  final signInFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // make text obscure for passwords
  bool _isObscure = false;
  get isObscure => _isObscure;
  set isObscure(value) {
    _isObscure = value;
    notifyListeners();
  }

  // to remember login info
  bool _isRemember = true;
  get isRemember => _isRemember;
  set isRemember(value) {
    _isRemember = value;
    notifyListeners();
  }

  void onSigninButton(context) async {
    if (signInFormKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final data = SignInModel(email: email, password: password);

      SignInResponseModel? signInResponse =
          await SignInService().signInRepo(data);
      if (signInResponse == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.popUp('No Response'));
        _isLoadingFalse();
        return;
      } else if (signInResponse.message == "true") {
        PushFunctions.push(context, const MainPage());
        _isLoadingFalse();
      } else if (signInResponse.message != "true") {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.popUp(signInResponse.message));
        _isLoadingFalse();
        return;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.popUp('Something went wrong !!'));
        _isLoadingFalse();
      }
    }
  }

  String? emailValidator(String? fieldContent) {
    if (fieldContent == null || fieldContent.isEmpty) {
      return 'Please fill the field';
    } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(fieldContent) &&
        !RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
            .hasMatch(fieldContent)) {
      return 'Enter a valid email / phone number';
    }
    return null;
  }

  String? passwordValidator(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }

  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  void disposes() {
    signInFormKey.currentState!.reset();
    emailController.clear();
    passwordController.clear();
    _isObscure = true;
    _isRemember = true;
    isLoading = false;
    notifyListeners();
  }
}
