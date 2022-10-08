import 'package:flutter/material.dart';


class NumVerifyViewModel extends ChangeNotifier {
  final numVerifyFormKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;


  void onGetOtpButton(context) async {
    if (numVerifyFormKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      //final email = numberController.text.trim();
      //final data = SignInModel(email: email, password: password);

      // SignInResponseModel? signInResponse =
      //     await SignInService().signInRepo(data);
      // if (signInResponse == null) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(ShowDialogs.popUp('No Response'));
      //   _isLoadingFalse();
      //   return;
      // } else if (signInResponse.message == "true") {
      //   PushFunctions.push(context, const MainPage());
      //   _isLoadingFalse();
      // } else if (signInResponse.message != "true") {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(ShowDialogs.popUp(signInResponse.message));
      //   _isLoadingFalse();
      //   return;
      // } else {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(ShowDialogs.popUp('Something went wrong !!'));
      //   _isLoadingFalse();
      // }
    }
  }

  String? numberValidator(String? fieldContent) {
    if (fieldContent == null || fieldContent.isEmpty) {
      return 'Please enter your mobile number';
    } else if (!RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
            .hasMatch(fieldContent)) {
      return 'Enter a valid mobile number';
    }
    return null;
  }

  // void _isLoadingFalse() {
  //   isLoading = false;
  //   notifyListeners();
  // }

  void disposes() {
    numVerifyFormKey.currentState!.reset();
    mobileNumberController.clear();
    isLoading = false;
    notifyListeners();
  }
}