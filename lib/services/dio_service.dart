import 'package:dio/dio.dart';
import 'package:premio_inn/utils/url.dart';

class DioService {
  static final dio = Dio(BaseOptions(baseUrl: Url.baseUrl));
  static Future<dynamic> postMethod(
      {required String url, required value}) async {
    return await dio.post(url, data: value).then((value){
      return value;
    });
  }

 
  // static Future<void> getMethod() {
  //   throw UnimplementedError();
  // }

}
