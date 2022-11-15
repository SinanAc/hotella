import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/screens/account/account_screen.dart';
import 'package:premio_inn/view/screens/home/home_screen.dart';
import 'package:premio_inn/view/screens/bookings/booking_screen.dart';

class MainPageViewModel extends ChangeNotifier {
  // ==========>>>>>  BOTTOM NAVIGATION INDEX  <<<<<==========
  int bottomNavIndex = 0;
  void changeBottomIndex(int idx) {
    bottomNavIndex = idx;
    notifyListeners();
  }

  // ==========>>>>>  BOTTOM NAVIGATION BAR ITEM LIST  <<<<<==========
  static List<BottomNavyBarItem> bottomItems = [
    BottomNavyBarItem(
      icon: const Icon(Icons.home),
      title: const Text('Home'),
      activeColor: KColors.kThemeGreen,
      inactiveColor: Colors.grey,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.card_travel),
      title: const Text('Bookings'),
      activeColor: KColors.kThemeGreen,
      inactiveColor: Colors.grey,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.favorite_border),
      title: const Text('Saved'),
      activeColor: KColors.kThemeGreen,
      inactiveColor: Colors.grey,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.person),
      title: const Text('Account'),
      activeColor: KColors.kThemeGreen,
      inactiveColor: Colors.grey,
      textAlign: TextAlign.center,
    ),
  ];

  // ==========>>>>>  MAIN PAGE SCREEN LIST  <<<<<==========
  static List<Widget> screenList = [
    const HomeScreen(),
    const BookingScreen(),
    const AccountScreen(),
  ];
}
