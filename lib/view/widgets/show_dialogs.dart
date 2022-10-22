import 'package:flutter/material.dart';
import 'package:premio_inn/utils/navigations.dart';

class ShowDialogs {
  static final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static popUp(String messege,
      {Color color = Colors.red, int milliSec = 2000}) {
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
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            messege,
            style: const TextStyle(
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  static dialogBox({required String messege, required Function goOn}) {
    showDialog(
        context: rootScaffoldMessengerKey.currentState!.context,
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
                onPressed: () {},
                child: const Text('Go on',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }
}
