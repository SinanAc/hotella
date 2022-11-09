import 'package:dio/dio.dart';
import 'package:premio_inn/model/bookings/payment/paynow_respo_model.dart';
import 'package:premio_inn/services/dio/api_exceptions.dart';
import 'package:premio_inn/services/dio/interceptor.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class PayNowService{
    // -->> api function to check is room available or not
  Future<PayNowResponseModel?> payNowService(int amount)async{
    final Dio dio = await InterceptorDio.getVerifiedUser();
        if (await internetCheck()) {
      try {
        final Response response = await dio.post(Url.paynow,data: {"price":amount});
        if (response.statusCode! >= 200 || response.statusCode! <= 299) {
          return PayNowResponseModel.fromJson(response.data);
        } else {
          return null;
        }
      } catch (e) {
        return PayNowResponseModel(message: ApiExceptions.handleError(e));
      }
    } else {
      return PayNowResponseModel(message: "No Internet !!");
    }
  }
}