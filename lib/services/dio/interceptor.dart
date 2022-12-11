import 'package:dio/dio.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterceptorDio {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: Url.baseUrl,
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    ),
  );
  static Future<Dio> getVerifiedUser() async {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (response, handler) async {
          final SharedPreferences pref = await SharedPreferences.getInstance();
          final String token = pref.getString(KStrings.token) ?? '';
          _dio.interceptors.clear();
          response.headers.addAll({"Authorization": "Bearer $token"});
          return handler.next(response);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            return;
          }
        },
        onResponse: ((kResponse, response) {
          return response.next(kResponse);
        }),
      ),
    );
    return _dio;
  }
}
