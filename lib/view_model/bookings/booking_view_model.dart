import 'package:flutter/material.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/services/booked/booked_rooms.dart';
import 'package:premio_inn/view/screens/bookings/widgets/bottom_sheet.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class BookedHotelsViewModel extends ChangeNotifier {
  // ==========>>>>>  VARIABLES  <<<<<==========
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
      _sortBookedList(bookedHotels);
      _isLoading = false;
      return;
    } else {
      ShowDialogs.popUp('No data');
      _isLoading = false;
    }
  }

  // ==========>>>>>  TO SORT  <<<<<==========
  void _sortBookedList(List<Completed> fullList) {
    upcomingList.clear();
    upcomingList
        .addAll(fullList.where((element) => element.isBooked == true).toList());
    completedList.clear();
    completedList.addAll(
        fullList.where((element) => element.completed == true).toList());
    cancelledList.clear();
    cancelledList
        .addAll(fullList.where((element) => element.cancel == true).toList());
  }

  // ==========>>>>>  BOTTOM SHEET TO SHOW BOOKED DETAILS  <<<<<==========
  void showMoreDetails(double height, Completed hotel) {
    showModalBottomSheet<BookedDetailsBottomSheet>(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      context: scaffoldKey.currentState!.context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (_) {
        return
            // Scaffold(
            //     body:
            BookedDetailsBottomSheet(
          hotel: hotel,
        );
        //);
      },
    );
  }

  // ==========>>>>>  TO CALCULATE TOTAL AMOUNT  <<<<<==========
  String totalAmount(int rooms, int price,int days) {
    if (rooms == 0 || price == 0 || days == 0) {
      return 'Not available';
    }
    final total = rooms * days * price;
    return '₹${total.toString()}';
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
