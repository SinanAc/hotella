import 'package:flutter/material.dart';
import 'package:premio_inn/utils/navigations.dart';

class ShowDialogs {
  static final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static popUp(
    String messege, {
    Color color = Colors.red,
    int milliSec = 2000,
    Color textColor = Colors.white,
  }) {
    rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        duration: Duration(milliseconds: milliSec),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        margin: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            messege,
            style:  TextStyle(
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  static void dialogBox(
      {required String messege, required Function goOn}) async {
    await showDialog(
        context: Navigations.navigatorKey.currentContext!,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Permission !',
            ),
            content: Text(messege),
            actions: [
              TextButton(
                onPressed: () {
                  Navigations.pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  goOn();
                },
                child: const Text('Go on',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }
}
