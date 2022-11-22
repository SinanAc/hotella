import 'package:flutter/material.dart';
import 'package:premio_inn/main.dart';
import 'package:premio_inn/view_model/account/account_view_model.dart';
import 'package:premio_inn/view_model/bookings/booking_view_model.dart';
import 'package:premio_inn/view_model/category/category.dart';
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
        ChangeNotifierProvider(create: (context) => MainPageViewModel()),
        ChangeNotifierProvider(create: (context) => SigninViewModel()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => HotelViewModel()),
        ChangeNotifierProvider(create: (context) => PhoneNumberViewModel()),
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        ChangeNotifierProvider(create: (context) => AccountViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => SearchViewModel()),
        ChangeNotifierProvider(create: (context) => CategoryViewModel()),
        ChangeNotifierProvider(create: (context) => BookedHotelsViewModel()),
      ],
      child: const MyApp(),
    );
  }
}
