import 'package:flutter/material.dart';
import 'package:premio_inn/model/register/sign_in/sign_in_model.dart';
import 'package:premio_inn/model/register/sign_in/signin_response_model.dart';
import 'package:premio_inn/services/register/sign_in_service.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninViewModel extends ChangeNotifier {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
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

  // sign in method
  Future<void> onSigninButton() async {
    if (signInFormKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      final phoneEmail = phoneOrEmailController.text.trim();
      final password = passwordController.text.trim();
      final data = SignInModel(phoneOrEmail: phoneEmail, password: password);

      SignInResponseModel? signInResponse =
          await SignInService().signInRepo(data);
      if (signInResponse == null) {
        ShowDialogs.popUp('No Response');
        _isLoadingFalse();
        return;
      } else if (signInResponse.isSuccess == true) {
        final pref = await SharedPreferences.getInstance();
        await pref.setBool(KStrings.isLogggedIn, true);
        await pref.setString(KStrings.token, signInResponse.profile?.token??'');
        _isLoadingFalse();
        disposes();
        Navigations.pushRemoveUntil(const MainPage());
      } else {
        ShowDialogs.popUp(
            signInResponse.message ?? 'Something went wrong !!');
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

  // to make isLoading false
  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  // to dispose all the variables
  void disposes() {
    signInFormKey.currentState!.reset();
    phoneOrEmailController.clear();
    passwordController.clear();
    isObscure = true;
    isLoading = false;
    notifyListeners();
  }
}
