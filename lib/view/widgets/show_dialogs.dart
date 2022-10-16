import 'package:flutter/material.dart';

class ShowDialogs {
  // error popup to display error messages
  static SnackBar errorPopUp(String messege,{int seconds = 1}) {
    return SnackBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        duration:  Duration(seconds: seconds),
        behavior: SnackBarBehavior.floating,
        backgroundColor:  Colors.red,
        margin: const EdgeInsets.all(10),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            messege,
            style: const TextStyle(
                letterSpacing: 2, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ));
  }
}
