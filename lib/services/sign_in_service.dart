import 'package:dio/dio.dart';
import 'package:premio_inn/model/sign_in/sign_in_model.dart';
import 'package:premio_inn/model/sign_in/signin_response_model.dart';
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
        if (e.response!.statusCode == 401) {
          return SignInResponseModel(message: "Email and password doesn't match !!");
        }else{
          return SignInResponseModel.fromJson(e.response!.data);
        }
      } catch (e) {
        return SignInResponseModel(message: e.toString());
      }
    } else {
      return SignInResponseModel(message: "No Internet !!");
    }
  }
}
