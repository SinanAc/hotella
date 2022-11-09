import 'package:flutter/material.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view/screens/register/phone_number_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends ChangeNotifier {
  // ==========>>>>>  TO CHECK, IS USER LOGGEDIN OR NOT  <<<<<==========
  Future<void> checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    final isLogggedIn = pref.getBool(KStrings.isLogggedIn);
    if (isLogggedIn == null || isLogggedIn == false) {
      Navigations.pushReplace(const PhoneNumberScreen());
    } else {
     Navigations.pushReplace(const MainPage());
     }
   }
}
