import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/bottom_sheet.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class HotelViewModel extends ChangeNotifier {
  // =========>>>>>  VARIABLES  <<<<<=========
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int guests = 1;
  int rooms = 1;
  int days = 1;
  int amount = 0;
  final PageController pController = PageController();

  // =========>>>>>  INITIAL VALUES  <<<<<=========
  void onInit() {
    selectedDates = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)));
    guests = 1;
    rooms = 1;
    days = 1;
    notifyListeners();
  }

  // =========>>>>>  TO SELECT DATE RANGE  <<<<<=========
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(
      const Duration(days: 1),
    ),
  );
  Future<void> selectDate(BuildContext ctx, int amount) async {
    selectedDates = await showDateRangePicker(
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDateRange: selectedDates,
          context: ctx,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
          confirmText: 'Confirm',
          cancelText: 'Cancel',
        ) ??
        selectedDates;
    daysBetween(selectedDates.start, selectedDates.end);
    totalAmount(amount);
    notifyListeners();
  }

  // =========>>>>>  TO INCREMENT ROOM COUNT  <<<<<=========  
  void roomCountPlus() {
    if (rooms < 10) {
      rooms++;
      if (guests < rooms) {
        guests++;
      }
    } else {
      ShowDialogs.popUp('10 rooms are alloweded at a time !!',
          color: Colors.black87);
    }
    notifyListeners();
  }

  // -->> function to room count --
  void roomCountMinus() {
    if (rooms > 1) {
      rooms--;
      if (guests > rooms * 2) {
        guests = guests - 2;
      }
    } else {
      ShowDialogs.popUp('At least one room is needed !!',
          color: Colors.black87);
    }
    notifyListeners();
  }

  // -->> function to guest count ++
  void guestCountPlus() {
    if (guests < rooms * 2) {
      guests++;
    } else {
      ShowDialogs.popUp('Only two guests are allowed in a room!!',
          color: Colors.black87);
    }
    notifyListeners();
  }

  // -->> function to guest count --
  void guestCountMinus() {
    if (guests > 1) {
      guests--;
      if (rooms > guests) {
        rooms--;
      }
    } else {
      ShowDialogs.popUp('At least one guest is needed !!',
          color: Colors.black87);
    }
    notifyListeners();
  }

  // -->> function to get the total days selected
  void daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    final totalDays = (to.difference(from).inHours / 24).round();
    days = totalDays;
    notifyListeners();
  }

  // -->> function to get the total amount to be paid
  int totalAmount(int amount) {
    final int total = rooms * days * amount;
    this.amount = amount;
    return total;
  }

  // -->> to get bottom sheet
  void selectRoomsAndGuests(double height, int amount, AllRoomsModel hotel) {
    showModalBottomSheet<RoomsAndGuestsBottomSheet>(
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.white,
      context: scaffoldKey.currentState!.context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (_) {
        return SizedBox(
            height: height,
            child: Scaffold(
                body: RoomsAndGuestsBottomSheet(
              amount: amount,
              hotel: hotel,
            )));
      },
    );
  }

  // ==========>>>>> FAVORITE BUTTON <<<<<==========
  final Icon notFavIcon = Icon(
    Icons.favorite_border,
    size: 32,
    color: Colors.grey.shade600,
  );
  final Icon favIcon = const Icon(
    Icons.favorite_outlined,
    color: KColors.kRedColor,
    size: 32,
  );
  bool _isFav = false;
  bool get isFav => _isFav;
  set isFav(value) {
    _isFav = value;
    notifyListeners();
  }
}
