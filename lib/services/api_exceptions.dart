import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class ApiExceptions {
  static String handleError(e) {
    String defaultErrorMsg = 'Something went wrong !';
    String networkErrorMsg = 'Poor network connection !';

    if (e is DioError) {
      if (e.response == null) {
        return defaultErrorMsg;
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return networkErrorMsg;
      } else if (e.type == DioErrorType.response) {
        if (e.response?.data["message"] != null) {
          return e.response?.data["message"];
        } else {
          return defaultErrorMsg;
        }
      }
    } else if (e is SocketException) {
      return networkErrorMsg;
    } else if (e is TimeoutException) {
      return defaultErrorMsg;
    } else {
      return defaultErrorMsg;
    }
    return networkErrorMsg;
  }
}
