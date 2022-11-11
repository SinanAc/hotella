import 'package:dio/dio.dart';
import 'package:premio_inn/model/bookings/complete/complete_req.dart';
import 'package:premio_inn/model/bookings/complete/response.dart';
import 'package:premio_inn/services/dio/api_exceptions.dart';
import 'package:premio_inn/services/dio/interceptor.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class BookingCompleteService {
  Future<CompleteBookingResponse?> bookingCompleteService(
      CompleteBookingRequestModel data,
      {String? signature}) async {
    final Dio dios = await InterceptorDio.getVerifiedUser();
    if (await internetCheck()) {
      late Response response;
      try {
        if (signature != null) {
          response = await dios.post(
            Url.complete,
            data: data.toJson(),
            options: Options(headers: {"signature": signature}),
          );
        } else {
          response = await dios.post(Url.complete, data: data.toJson());
        }
        if (response.statusCode! >= 200 || response.statusCode! <= 299) {
          return CompleteBookingResponse.fromJson(response.data);
        } else {
          return null;
        }
      } catch (e) {
        return CompleteBookingResponse(message: ApiExceptions.handleError(e));
      }
    } else {
      return CompleteBookingResponse(message: "No Internet !!");
    }
  }
}
