import 'package:flutter/material.dart';

class ShowDialogs {

    static final GlobalKey<ScaffoldMessengerState>  rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static popUp( 
    String messege, 
    {
      Color color = Colors.red,
      int milliSec = 2000
    }) {
    // Size size =
    //     MediaQuery.of(rootScaffoldMessengerKey.currentState!.context).size;
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        duration:  Duration(milliseconds: milliSec),
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

}
