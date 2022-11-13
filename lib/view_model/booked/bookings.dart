import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/services/booked/booked_rooms.dart';

class BookedHotelsViewModel extends ChangeNotifier {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;
  final List<Completed> bookedHotels = [];
  Future<void> getAllBookedHotels() async {
    final BookedRoomsModel? response = await BookedRoomsService().bookedRooms();
    if (response == null) {
      return;
    } else if (response.success == true) {
      bookedHotels.clear();
      bookedHotels.addAll(response.completed ?? []);
      notifyListeners();
    } else {
      log('no data');
      log(response.success.toString());
    }
  }
}
