import 'dart:async';
import 'package:dio/dio.dart';
import 'package:premio_inn/model/home/all_rooms.dart';
import 'package:premio_inn/model/home/response.dart';
import 'package:premio_inn/services/dio/dio_service.dart';
import 'package:premio_inn/services/dio/api_exceptions.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class GetAllRoomsService {
  Future<AllRoomsResponse> getAllRooms() async {
    if (await internetCheck()) {
      try {
        final Response response =
            await DioService.getMethod(url: Url.getAllRooms);
        if (response.statusCode! >= 200 || response.statusCode! <= 299) {
          final dataList = (response.data as List).map((e) {
            return AllRoomsModel.fromJson(e);
          }).toList();
          return AllRoomsResponse(dataList: dataList);
        } else {
          return AllRoomsResponse(
              isFailed: true,
              errormessage: 'Something went wrong ! Please try again later');
        }
      } catch (e) {
        return AllRoomsResponse(
            isFailed: true, errormessage: ApiExceptions.handleError(e));
      }
    } else {
      await Future.delayed(const Duration(seconds: 1));
      return AllRoomsResponse(
          isFailed: true, errormessage: 'Poor internet connection!!');
    }
  }
}
