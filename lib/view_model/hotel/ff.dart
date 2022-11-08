import 'package:flutter/cupertino.dart';

class A extends ChangeNotifier{
  void a(){
    notifyListeners();
  }
}