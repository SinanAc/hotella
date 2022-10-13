import 'dart:io';

import 'package:dio/dio.dart';
import 'package:premio_inn/model/register/otp/otp_model.dart';
import 'package:premio_inn/model/register/otp/otp_response_model.dart';
import 'package:premio_inn/model/register/phone_number/phone_number_model.dart';
import 'package:premio_inn/model/register/phone_number/phone_number_response_model.dart';
import 'package:premio_inn/services/dio_service.dart';
import 'package:premio_inn/services/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class PhoneNumberService {
  // phone number verify service
  Future<PhoneNumberResponseModel?> phoneNumberRepo(
      PhoneNumberModel data) async {
    if (await internetCheck()) {
      try {
        final response =
            await DioService.postMethod(url: Url.sendOtp, value: data.toJson());
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          return PhoneNumberResponseModel.fromJson(response.data);
        } else {
          return PhoneNumberResponseModel.fromJson(response.data);
        }
      } on DioError catch (e) {
        return PhoneNumberResponseModel.fromJson(e.response!.data);
      } on SocketException catch (e) {
        return PhoneNumberResponseModel(message: e.message);
      } catch (e) {
        return PhoneNumberResponseModel(message: e.toString());
      }
    } else {
      return PhoneNumberResponseModel(message: "No Internet !!");
    }
  }

  // otp verify service
  Future<OtpResponseModel?> otpVerifyRepo(OtpModel data) async {
    if (await internetCheck()) {
      try {
        final response = await DioService.postMethod(
            url: Url.otpVerify, value: data.toJson());
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          return OtpResponseModel.fromJson(response.data);
        } else {
          return OtpResponseModel.fromJson(response.data);
        }
      } on DioError catch (e) {
        return OtpResponseModel.fromJson(e.response!.data);
      }on SocketException catch (e) {
        return OtpResponseModel(message: e.message);
      }  
      catch (e) {
        return OtpResponseModel(message: e.toString());
      }
    } else {
      return OtpResponseModel(message: "No Internet !!");
    }
  }
}
