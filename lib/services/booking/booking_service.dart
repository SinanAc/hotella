import 'package:dio/dio.dart';
import 'package:premio_inn/model/bookings/room_availability/request.dart';
import 'package:premio_inn/model/bookings/room_availability/response.dart';
import 'package:premio_inn/services/dio/api_exceptions.dart';
import 'package:premio_inn/services/dio/dio_service.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class BookingService {
  // -->> api function to check is room available or not
  Future<RoomAvailabilityResponseModel?> isRoomAvailabileService(RoomAvailabiltyRequestModel data)async{
        if (await internetCheck()) {
      try {
        final Response response =
            await DioService.postMethod(url: Url.isRoomAvailabile, value: data.toJson());
        if (response.statusCode! >= 200 || response.statusCode! <= 299) {
          return RoomAvailabilityResponseModel.fromJson(response.data);
        } else {
          return null;
        }
      } catch (e) {
        return RoomAvailabilityResponseModel(message: ApiExceptions.handleError(e));
      }
    } else {
      return RoomAvailabilityResponseModel(message: "No Internet !!");
    }
  }
}