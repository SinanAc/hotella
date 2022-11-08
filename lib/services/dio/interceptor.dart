import 'package:dio/dio.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Interceptorapi {
  static final  Dio _dio = Dio();
  static Future<Dio> getApiUser() async {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (response, handler) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final String token = pref.getString(KStrings.token) ?? '';
      _dio.interceptors.clear();
      response.headers.addAll({"Authorization": "Bearer $token"});
      return handler.next(response);
    }, onError: (e, handler) async {
      if (e.response?.statusCode == 401) {
        return;
      }
    }, onResponse: ((kResponse, response) {
      return response.next(kResponse);
    })));
    return _dio;
  }
}
