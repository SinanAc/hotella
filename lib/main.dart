import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/screens/splash/splash_screen.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:premio_inn/view_model/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Providers.providers());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: KColors.primarySwatchColor,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
        ),
         appBarTheme: const AppBarTheme(
      backgroundColor: KColors.kThemeGreen,
      toolbarHeight: 0,
      elevation: 0,
    ),
      ),
      navigatorKey: Navigations.navigatorKey,
      scaffoldMessengerKey: ShowDialogs.rootScaffoldMessengerKey,
      home: const SplashScreen(),
    );
  }
}
