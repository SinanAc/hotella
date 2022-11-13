import 'dart:async';
import 'package:dio/dio.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/services/dio/dio_service.dart';
import 'package:premio_inn/services/dio/api_exceptions.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class BookedRoomsService {
  Future<BookedRoomsModel?> bookedRooms() async {
    if (await internetCheck()) { 
      try {
        final Response response = await DioService.getMethod(url: Url.getAllRooms);
        if (response.statusCode! >= 200 || response.statusCode! <= 299) {
        return BookedRoomsModel.fromJson(response.data);
        } else {
          return BookedRoomsModel(message: 'Something went wrong ! Please try again later' );
        }
      } catch (e) {
        return BookedRoomsModel(message: ApiExceptions.handleError(e));
      }
    } else {
      await Future.delayed(const Duration(seconds: 1));
      return null;
    }
  }

}