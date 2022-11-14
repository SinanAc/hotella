import 'package:flutter/material.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/services/booked/booked_rooms.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class BookedHotelsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final List<Completed> bookedHotels = [];
  final List<Completed> upcomingList = [];
  final List<Completed> completedList = [];
  final List<Completed> cancelledList = [];
  Future<void> getAllBookedHotels() async {
    _isLoading = true;
    final BookedRoomsModel? response = await BookedRoomsService().bookedRooms();
    if (response == null) {
      _isLoading = false;
      return;
    } else if (response.success == true) {
      bookedHotels.clear();
      bookedHotels.addAll(response.completed ?? []);
      _isLoading = false;
      return;
    } else {
      ShowDialogs.popUp('No data');
      _isLoading = false;
    }
  }

  // // ==========>>>>>  TO MAKE LOADING TRUE  <<<<<==========
  // void _isLoadingTrue() {
  //   _isLoading = true;
  //   notifyListeners();
  // }

  // // ==========>>>>>  TO MAKE LOADING FALSE  <<<<<==========
  // void _isLoadingFalse() {
  //   _isLoading = false;
  //   notifyListeners();
  // }
}
