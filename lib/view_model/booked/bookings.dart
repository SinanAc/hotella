import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/services/booked/booked_rooms.dart';

class BookedHotelsViewModel extends ChangeNotifier {
  BookedHotelsViewModel(){
    getAllBookedHotels();
  }
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final List<Completed> bookedHotels = [];
  Future<void> getAllBookedHotels() async {
    _isLoadingTrue();
    final BookedRoomsModel? response = await BookedRoomsService().bookedRooms();
    if (response == null) {
      _isLoadingFalse();
      return;
    } else if (response.success == true) {
      bookedHotels.clear();
      bookedHotels.addAll(response.completed ?? []);
     // notifyListeners();
      _isLoadingFalse();
      return;
    } else {
      log('no data');
      _isLoadingFalse();
    }
  }

    // ==========>>>>>  TO MAKE LOADING TRUE  <<<<<==========
  void _isLoadingTrue() {
    _isLoading = true;
   // notifyListeners();
  }

  // ==========>>>>>  TO MAKE LOADING FALSE  <<<<<==========
  void _isLoadingFalse() {
    _isLoading = false;
    //notifyListeners();
  }
}
