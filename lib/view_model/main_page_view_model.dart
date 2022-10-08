import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/screens/account/account_screen.dart';
import 'package:premio_inn/view/screens/saved/saved_screen.dart';
import 'package:premio_inn/view/screens/home/home_screen.dart';
import 'package:premio_inn/view/screens/bookings/booking_screen.dart';

class MainPageViewModel extends ChangeNotifier{
    // variables
  int _bottomNavIndex = 0;

  // getters
  get bottomNavIndex => _bottomNavIndex;

  // setters
  set bottomNavIndex(index) {
    _bottomNavIndex = index;
    notifyListeners();
  }

  // main page bottomNav item list
  static List<BottomNavyBarItem> bottomItems = [
    BottomNavyBarItem(
        icon: const Icon(Icons.home),
        title: const Text('Home'),
        activeColor: KColors.kThemeGreen,
        inactiveColor: Colors.grey,
        textAlign: TextAlign.center),
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

  // main page screen list 
  static List<Widget> screenList = [
    const HomeScreen(),
    const BookingScreen(),
    const SavedScreen(),
    const AccountScreen(),
  ];  
}
