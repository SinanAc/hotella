import 'package:flutter/material.dart';
import 'package:premio_inn/main.dart';
import 'package:premio_inn/view_model/account/account_view_model.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:premio_inn/view_model/hotel/hotel_view_model.dart';
import 'package:premio_inn/view_model/main_page/main_page_view_model.dart';
import 'package:premio_inn/view_model/register/phone_number.dart';
import 'package:premio_inn/view_model/register/signin_view_model.dart';
import 'package:premio_inn/view_model/register/signup_viewmodel.dart';
import 'package:premio_inn/view_model/search/search_view_model.dart';
import 'package:premio_inn/view_model/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

class Providers {
  static Widget providers() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainPageViewModel()),
        ChangeNotifierProvider(create: (_) => SigninViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => HotelViewModel()),
        ChangeNotifierProvider(create: (_) => PhoneNumberViewModel()),
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        ChangeNotifierProvider(create: (_) => AccountViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
      ],
      child: const MyApp(),
    );
  }
}