import 'package:flutter/cupertino.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/url.dart';
import 'package:premio_inn/view/screens/register/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountViewModel extends ChangeNotifier {
  // logout function
  Future<void> onLogoutButton(ctx) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(Url.isLogggedIn, false);
    PushFunctions.pushAndRemoveUntil(ctx, const SignInScreen());
  }
}
