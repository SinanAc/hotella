import 'package:flutter/material.dart';
import 'package:premio_inn/model/register/otp/otp_model.dart';
import 'package:premio_inn/model/register/otp/otp_response_model.dart';
import 'package:premio_inn/model/register/phone_number/phone_number_model.dart';
import 'package:premio_inn/model/register/phone_number/phone_number_response_model.dart';
import 'package:premio_inn/services/register/mobile_number_service.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/screens/register/signup_screen.dart';
import 'package:premio_inn/view/screens/register/widgets/bottom_sheet.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class PhoneNumberViewModel extends ChangeNotifier {
  // variables
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> numVerifyFormKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String hash = '';
  bool isLoading = false;

  // this function will be called when get otp button is clicked
  Future<void> onGetOtpButton() async {
    if (numVerifyFormKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      final phoneNum = mobileNumberController.text.trim();
      final data = PhoneNumberModel(phoneNumber: phoneNum);
      PhoneNumberResponseModel? phoneResponse =
          await PhoneNumberService().phoneNumberRepo(data);
      if (phoneResponse == null) {
        ShowDialogs.popUp('Something went wrong !!');
        _isLoadingFalse();
        return;
      } else if (phoneResponse.success == true) {
        hash = phoneResponse.hash ?? '';
        goToOtpBottomSheet();
        _isLoadingFalse();
      } else {
        ShowDialogs.popUp(phoneResponse.message ?? 'Something went wrong !!');
        _isLoadingFalse();
        return;
      }
    }
  }

  // this function will be called when verify otp button is clicked
  Future<void> onOtpVerifyButton() async {
    isLoading = true;
    notifyListeners();
    final otp = otpController.text.trim();
    final data = OtpModel(otp: otp, hash: hash);
    OtpResponseModel? otpResponse =
        await PhoneNumberService().otpVerifyRepo(data);
    if (otpResponse == null) {
      ShowDialogs.popUp('Something went wrong !!');
      _isLoadingFalse();
      return;
    } else if (otpResponse.created == true) {
      mobileNumberController.clear();
      otpController.clear();
      Navigations.pop();
      disposes();
      Navigations.push(
        SignupScreen(
          phoneNumber: otpResponse.phone!,
        ),
      );
      _isLoadingFalse();
    } else {
      ShowDialogs.popUp(otpResponse.message ?? 'Something went wrong !!');
      _isLoadingFalse();
      return;
    }
  }

// function to validate mobile number
  String? phoneNumberValidator(String? fieldContent) {
    if (fieldContent == null || fieldContent.isEmpty) {
      return 'Please enter your mobile number';
    } else if (!RegExp(
            r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
        .hasMatch(fieldContent)) {
      return 'Enter a valid mobile number';
    }
    return null;
  }

  // make isLoading false
  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  // function to call bottom sheet
  void goToOtpBottomSheet() {
    showModalBottomSheet<OtpBottomSheet>(
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: scaffoldKey.currentState!.context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (_) {
        return OtpBottomSheet(
            size: MediaQuery.of(scaffoldKey.currentState!.context).size);
      },
    );
  }

  // function dispose all variables
  void disposes() {
    numVerifyFormKey.currentState!.reset();
    mobileNumberController.clear();
    isLoading = false;
    notifyListeners();
  }
}
