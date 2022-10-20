import 'package:dio/dio.dart';
import 'package:premio_inn/utils/url.dart';

class DioService {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: Url.baseUrl,
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    ),
  );

  // ======== DIO POST METHOD ========
  static Future<dynamic> postMethod(
      {required String url, required value}) async {
    return await _dio.post(url, data: value).then((value) => value);
  }

  // ======== DIO GET METHOD ========
  static Future<Response> getMethod({required String url}) async {
    return await _dio.get(url).then((value) => value);
  }
}
