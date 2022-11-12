import 'package:flutter/material.dart';
import 'package:premio_inn/model/register/sign_in/signin_response_model.dart';
import 'package:premio_inn/model/register/sign_up/signup_model.dart';
import 'package:premio_inn/services/register/signup_service.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpViewModel extends ChangeNotifier {
  // ==========>>>>>  VARIABLES  <<<<<==========
  final signUpKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  // ==========>>>>>  TO MAKE PASSWORD OBSCURE  <<<<<==========
  bool _isObscure = true;
  get isObscure => _isObscure;
  set isObscure(value) {
    _isObscure = value;
    notifyListeners();
  }

  // ==========>>>>>  SIGNUP  <<<<<==========
  Future<void> onSignupButton(String phoneNum) async {
    if (signUpKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      final obj = SignUpModel(
        name: nameController.text.trim(),
        phone: phoneNum,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      SignInResponseModel? signUpResponse =
          await SignUpService().signUpRepo(obj);
      if (signUpResponse == null) {
        ShowDialogs.popUp('No Response');
        _isLoadingFalse();
        return;
      } else if (signUpResponse.isSuccess == true) {
        final pref = await SharedPreferences.getInstance();
        await pref.setString(KStrings.phone, phoneNum);
        await _storeUserData(signUpResponse);
        Navigations.push(const MainPage());
        _isLoadingFalse();
      } else {
        ShowDialogs.popUp("${signUpResponse.message}");
        _isLoadingFalse();
        return;
      }
    }
  }

  // ==========>>>>>  TEXTFIELD VALIDATIONS  <<<<<==========
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

  // ==========>>>>>  TO MAKE LOADING FALSE  <<<<<==========
  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  // ==========>>>>> STORING USER DATA LOCALLY  <<<<<==========
  Future<void> _storeUserData(SignInResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(KStrings.isLogggedIn, true);
    await pref.setString(KStrings.userName, data.profile?.name ?? '');
    await pref.setString(KStrings.email, data.profile?.email ?? '');
    await pref.setString(KStrings.token, data.profile?.token ?? '');
  }

  // ==========>>>>> DISPOSE VARIABLES  <<<<<==========
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
