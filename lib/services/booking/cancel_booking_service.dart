import 'package:dio/dio.dart';
import 'package:premio_inn/model/booking/cancel/cancel_response.dart';
import 'package:premio_inn/services/dio/api_exceptions.dart';
import 'package:premio_inn/services/dio/interceptor.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class CancelBookingService {
  Future<CancelResponseModel> cancelBooking(String id) async {
    if (await internetCheck()) {
      final Dio dios = await InterceptorDio.getVerifiedUser();
      try {
        final Response response =
            await dios.patch(Url.cancelBooking, data: {"id":id});
        if (response.statusCode! >= 200 || response.statusCode! <= 299) {
          return CancelResponseModel.fromJson(response.data);
        } else {
          return CancelResponseModel(message: "Something went wrong!! Please try again later");
        }
      } catch (e) {
        return CancelResponseModel(message: ApiExceptions.handleError(e));
      }
    } else {
      return CancelResponseModel(message: "Poor internet connection!!");
    }
  }
}