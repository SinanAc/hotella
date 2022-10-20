import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

class ApiExceptions {
  static String handleError(e) {
    String defaultErrorMsg = 'Something went wrong !';
    String networkErrorMsg = 'Poor network connection !';
    String timeOutMsg = 'Connection timed out !';

    if (e is DioError) {
      if (e.response == null) {
        return defaultErrorMsg;
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return timeOutMsg;
      } else if (e.type == DioErrorType.response) {
          return e.response?.data["message"] ?? defaultErrorMsg;
        }
    } else if (e is SocketException) {
      return networkErrorMsg;
    }else if (e is FormatException) {
      return 'Wrong format !';
    }
     else if (e is TimeoutException) {
      return timeOutMsg;
    } else {
      return defaultErrorMsg;
    }
    return networkErrorMsg;
  }
}
