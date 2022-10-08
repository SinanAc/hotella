import 'package:flutter/material.dart';

class PushFunctions {
  static push(context, page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static pushAndRemoveUntil(context, page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
  }

  static pushReplace(context, page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  static pop(context){
    Navigator.of(context).pop();
  }
}