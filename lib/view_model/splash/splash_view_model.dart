import 'package:flutter/cupertino.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';

class SplashViewModel extends ChangeNotifier {
  // this function is to check wheather the user is logged in or not
  Future<void> checkLogin(context) async {
    // final pref = await SharedPreferences.getInstance();
    // final isLogggedIn = pref.getBool(Url.isLogggedIn);
    // if (isLogggedIn == null || isLogggedIn == false) {
    //   PushFunctions.pushReplace(context, const PhoneNumberScreen());
    // } else {
      PushFunctions.pushReplace(context, const MainPage());
   // }
  }
}
