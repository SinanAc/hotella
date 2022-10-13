import 'package:flutter/material.dart';
import 'package:premio_inn/view/screens/splash/splash_screen.dart';
import 'package:premio_inn/view_model/account/account_view_model.dart';
import 'package:premio_inn/view_model/hotel_view_model.dart';
import 'package:premio_inn/view_model/main_page/main_page_view_model.dart';
import 'package:premio_inn/view_model/register/phone_number.dart';
import 'package:premio_inn/view_model/register/signin_view_model.dart';
import 'package:premio_inn/view_model/register/signup_viewmodel.dart';
import 'package:premio_inn/view_model/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> MainPageViewModel()),
        ChangeNotifierProvider(create: (_)=> SigninViewModel()),
        ChangeNotifierProvider(create: (_)=> SignUpViewModel()),
        ChangeNotifierProvider(create: (_)=> HotelViewModel()),
        ChangeNotifierProvider(create: (_)=> PhoneNumberViewModel()),
        ChangeNotifierProvider(create: (_)=> SplashViewModel()),
        ChangeNotifierProvider(create: (_)=> AccountViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),  
      ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
