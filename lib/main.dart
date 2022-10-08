import 'package:flutter/material.dart';
import 'package:premio_inn/view/screens/main_page/main_page.dart';
import 'package:premio_inn/view_model/food_item_view_model.dart';
import 'package:premio_inn/view_model/main_page_view_model.dart';
import 'package:premio_inn/view_model/register/number_verify.dart';
import 'package:premio_inn/view_model/register/signin_view_model.dart';
import 'package:premio_inn/view_model/register/signup_viewmodel.dart';
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
        ChangeNotifierProvider(create: (context)=> MainPageViewModel()),
        ChangeNotifierProvider(create: (context)=> SigninViewModel()),
        ChangeNotifierProvider(create: (context)=> SignUpViewModel()),
        ChangeNotifierProvider(create: (context)=> HotelViewModel()),
        ChangeNotifierProvider(create: (context)=> NumVerifyViewModel()),
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
        home: const MainPage(),
      ),
    );
  }
}
