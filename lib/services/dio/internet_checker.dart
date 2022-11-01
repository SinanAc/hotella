import 'dart:io';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// Future<bool> internetCheck() async {
//   bool result = await InternetConnectionChecker().hasConnection;
//   return result;
// }

Future<bool> internetCheck() async {
  try {
    final List<InternetAddress> result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } on SocketException catch (_) {
    return false;
  }
}
