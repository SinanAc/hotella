import 'package:flutter/material.dart';
import 'package:premio_inn/model/register/otp/otp_model.dart';
import 'package:premio_inn/model/register/otp/otp_response_model.dart';
import 'package:premio_inn/model/register/phone_number/phone_number_model.dart';
import 'package:premio_inn/model/register/phone_number/phone_number_response_model.dart';
import 'package:premio_inn/services/register/mobile_number_service.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/view/screens/register/signup_screen.dart';
import 'package:premio_inn/view/screens/register/widgets/bottom_sheet.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class PhoneNumberViewModel extends ChangeNotifier {
  final numVerifyFormKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String hash = '';
  bool isLoading = false;

  // this function will be called when get otp button is clicked
  void onGetOtpButton(context) async {
    if (numVerifyFormKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      final phoneNum = mobileNumberController.text.trim();
      final data = PhoneNumberModel(phoneNumber: phoneNum);
      PhoneNumberResponseModel? phoneResponse =
          await PhoneNumberService().phoneNumberRepo(data);
      if (phoneResponse == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(ShowDialogs.errorPopUp('Something went wrong !!'));
        _isLoadingFalse();
        return;
      } else if (phoneResponse.created == true) {
        hash = phoneResponse.hash ?? '';
        showModalBottomSheet(
            isDismissible: false,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return ShowBottomSheet(size: MediaQuery.of(context).size);
            });
        _isLoadingFalse();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(ShowDialogs.errorPopUp(
            phoneResponse.message ?? 'Something went wrong !!'));
        _isLoadingFalse();
        return;
      }
    }
  }

// this function will be called when verify otp button is clicked
  void onOtpVerifyButton(context) async {
    isLoading = true;
    notifyListeners();
    final otp = otpController.text.trim();
    final data = OtpModel(otp: otp, hash: hash);
    OtpResponseModel? otpResponse =
        await PhoneNumberService().otpVerifyRepo(data);
    if (otpResponse == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(ShowDialogs.errorPopUp('Something went wrong !!'));
      _isLoadingFalse();
      return;
    } else if (otpResponse.created == true) {
      mobileNumberController.clear();
      otpController.clear();
      PushFunctions.pop(context);
      PushFunctions.push(
        context,
        SignupScreen(
          phoneNumber: otpResponse.phone!,
        ),
      );
      _isLoadingFalse();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(ShowDialogs.errorPopUp(
          otpResponse.message ?? 'Something went wrong !!'));
      _isLoadingFalse();
      return;
    }
  }

// function to validate mobile number
  String? phoneNumberValidator(String? fieldContent) {
    if (fieldContent == null || fieldContent.isEmpty) {
      return 'Please enter your mobile number';
    } else if (!RegExp(
            r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)'
            )
        .hasMatch(fieldContent)) {
      return 'Enter a valid mobile number';
    }
    return null;
  }

  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  void disposes() {
    numVerifyFormKey.currentState!.reset();
    mobileNumberController.clear();
    isLoading = false;
    notifyListeners();
  }
}
