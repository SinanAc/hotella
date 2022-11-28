import 'package:dio/dio.dart';
import 'package:premio_inn/model/register/sign_in/signin_response_model.dart';
import 'package:premio_inn/model/register/sign_up/signup_model.dart';
import 'package:premio_inn/services/dio/api_exceptions.dart';
import 'package:premio_inn/services/dio/dio_service.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class SignUpService {
  Future<SignInResponseModel> signUpRepo(SignUpModel data) async {
    if (await internetCheck()) {
      try {
        final Response response =
            await DioService.postMethod(url: Url.signup, value: data.toJson());
        if (response.statusCode == 200 && response.statusCode! <= 299) {
          return SignInResponseModel.fromJson(response.data);
        } else {
          return SignInResponseModel.fromJson(response.data);
        }
      } catch (e) {
        return SignInResponseModel(message: ApiExceptions.handleError(e));
      }
    } else {
      return SignInResponseModel(message: "Poor internet connection!!");
    }
  }
}
