import 'package:flutter/material.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/screens/register/sign_in_screen.dart';
import 'package:premio_inn/view_model/main_page/main_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountViewModel extends ChangeNotifier {
  // ==========>>>>>  LOGOUT METHOD  <<<<<==========
  Future<void> onLogoutButton(context) async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    Provider.of<MainPageViewModel>(context, listen: false).bottomNavIndex = 0;
    Navigations.pushRemoveUntil(const SignInScreen());
  }
}
