import 'package:flutter/material.dart';
import 'package:premio_inn/model/register/sign_in/sign_in_model.dart';
import 'package:premio_inn/model/register/sign_in/signin_response_model.dart';
import 'package:premio_inn/services/register/sign_in_service.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninViewModel extends ChangeNotifier {
  final signInFormKey = GlobalKey<FormState>();
  final phoneOrEmailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // make text obscure for passwords
  bool _isObscure = true;
  get isObscure => _isObscure;
  set isObscure(value) {
    _isObscure = value;
    notifyListeners();
  }

  // to remember login details
  bool _isRemember = true;
  get isRemember => _isRemember;
  set isRemember(value) {
    _isRemember = value;
    notifyListeners();
  }

  // sign in method
  void onSigninButton(context) async {
    if (signInFormKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      final phoneEmail = phoneOrEmailController.text.trim();
      final password = passwordController.text.trim();
      final data = SignInModel(phoneOrEmail: phoneEmail, password: password);

      SignInResponseModel? signInResponse =
          await SignInService().signInRepo(data);
      if (signInResponse == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.errorPopUp('No Response'));
        _isLoadingFalse();
        return;
      } else if (signInResponse.created == true) {
        final pref = await SharedPreferences.getInstance();
        await pref.setBool(KStrings.isLogggedIn, true);
        _isLoadingFalse();
        disposes();
        PushFunctions.push(context, const MainPage());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(ShowDialogs.errorPopUp(
            signInResponse.message ?? 'Something went wrong !!'));
        _isLoadingFalse();
      }
    }
  }

  // text field validation functions
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

  // to dispose all the variables
  void disposes() {
    signInFormKey.currentState!.reset();
    phoneOrEmailController.clear();
    passwordController.clear();
    isRemember = true;
    isObscure = true;
    isLoading = false;
    notifyListeners();
  }
}
