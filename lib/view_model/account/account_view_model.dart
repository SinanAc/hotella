import 'package:flutter/cupertino.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/screens/register/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountViewModel extends ChangeNotifier {
  // logout function
  Future<void> onLogoutButton() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(KStrings.isLogggedIn, false);
    Navigations.pushRemoveUntil(const SignInScreen());
  }
}
