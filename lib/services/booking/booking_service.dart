import 'package:dio/dio.dart';
import 'package:premio_inn/model/bookings/booking/booking_req.dart';
import 'package:premio_inn/model/bookings/booking/booking_respo.dart';
import 'package:premio_inn/services/dio/api_exceptions.dart';
import 'package:premio_inn/services/dio/interceptor.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class BookingService {
  Future<BookingResponseModel?> bookingService(BookingRequestModel data)async{
    final Dio dios = await Interceptorapi.getApiUser();
        if (await internetCheck()) {
      try {
        final Response response = await dios.post(Url.booking,data: data.toJson());
        if (response.statusCode! >= 200 || response.statusCode! <= 299) {
          return BookingResponseModel.fromJson(response.data);
        } else {
          return null;
        }
      } catch (e) {
        return BookingResponseModel(message: ApiExceptions.handleError(e));
      }
    } else {
      return BookingResponseModel(message: "No Internet !!");
    }
  }
}