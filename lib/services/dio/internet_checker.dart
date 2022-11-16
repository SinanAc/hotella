import 'dart:io';
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
  } catch(_){
    return false;
  }
}
