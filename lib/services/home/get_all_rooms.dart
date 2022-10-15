import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/services/dio_service.dart';
import 'package:premio_inn/services/exceptions.dart';
import 'package:premio_inn/services/internet_checker.dart';
import 'package:premio_inn/utils/url.dart';

class GetAllRoomsService {
  Future<List<AllRoomssModel>?> getALlRooms() async {
    if (await internetCheck()) {
      try {
        final Response response = await DioService.getMethod(url: Url.getAllRooms);
        if (response.statusCode! >= 200 || response.statusCode! <= 299) {
          log('=========================');
           final dataList = (response.data as List).map((e) {
          return AllRoomssModel.fromJson(e);
        }).toList();
        return dataList;
        } else {
          throw Exception(
          'Error Occured while connecting to server With StatusCode :${response.statusCode}',
        );
        }
      } on DioError catch (_) {
        throw NoserviceException(message: '');
      } on SocketException catch (_) {
        throw NetWorkException(message: 'Connection Faild !!');
      } on TimeoutException catch (_) {
       // throw ConnectionTimeOutException(massage: 'Connection timed out !!');
       return [];
      } catch (_) {
        final response = await DioService.getMethod(url: Url.getAllRooms);
        throw ErrorResponse.processResponse(response);
      }
    } else {
      throw NetWorkException(message: 'Connection Faild !!');
    }
  }

}
