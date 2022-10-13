import 'dart:io';

import 'package:dio/dio.dart';
import 'package:premio_inn/model/register/sign_in/sign_in_model.dart';
import 'package:premio_inn/model/register/sign_in/signin_response_model.dart';
import 'package:premio_inn/services/dio_service.dart';
import 'package:premio_inn/services/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class SignInService {
  Future<SignInResponseModel?> signInRepo(SignInModel data) async {
    if (await internetCheck()) {
      try {
        final response =
            await DioService.postMethod(url: Url.login, value: data.toJson());
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          return SignInResponseModel.fromJson(response.data);
        } else {
          return SignInResponseModel.fromJson(response.data);
        }
      } on DioError catch (e) {
          return SignInResponseModel.fromJson(e.response!.data);
      }on SocketException catch (e) {
        return SignInResponseModel(message: e.message);
      }
       catch (e) {
        return SignInResponseModel(message: e.toString());
      }
    } else {
      return SignInResponseModel(message: "No Internet !!");
    }
  }
}
