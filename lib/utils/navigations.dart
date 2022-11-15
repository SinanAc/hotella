import 'package:flutter/material.dart';

class Navigations {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static push(page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  static pop() {
    navigatorKey.currentState?.pop();
  }
  
  static pushReplace(page) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  static pushRemoveUntil(page) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );
  }
}
