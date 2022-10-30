import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class HotelViewModel extends ChangeNotifier {
  // -->> constructor to get initial values

  // HotelViewModel() {
  //   selectedDates = DateTimeRange(
  //       start: DateTime.now(),
  //       end: DateTime.now().add(const Duration(days: 1)));
  //   guests = 1;
  //   rooms = 1;
  //   notifyListeners();
  // }
  
  // -->> vaiables
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(
      const Duration(days: 1),
    ),
  );
  int guests = 1;
  int rooms = 1;
  int days = 1;
  final Icon notFavIcon = Icon(
    Icons.favorite_border,
    size: 32,
    color: Colors.grey.shade600,
  );
  final Icon favIcon =
      const Icon(Icons.favorite_outlined, color: KColors.kRedColor, size: 32);
  final PageController pController = PageController();

  // -->> function to select date range
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

  // -->> function to room count ++
  void roomCountPlus() {
    if (rooms < 10) {
      rooms++;
      if (guests < rooms) {
        guests++;
      }
    } else {
      ShowDialogs.popUp('You can only book 10 rooms at a time');
    }
    notifyListeners();
  }

  // -->> function to room count --
  void roomCountMinus() {
    if (rooms > 1) {
      rooms--;
      if (guests > rooms * 2) {
        guests--;
      }
    } else {
      ShowDialogs.popUp('At least one room needed');
    }
    notifyListeners();
  }

  // -->> function to guest count ++
  void guestCountPlus() {
    if (guests < rooms * 2) {
      guests++;
    } else {
      ShowDialogs.popUp('You can only add two guests per one room');
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
      ShowDialogs.popUp('At least one guest needed');
    }
    notifyListeners();
  }

  // -->> function to reset rooms and guests count
  void resetCount() {
    guests = 1;
    rooms = 1;
    notifyListeners();
    Navigations.pop();
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
    notifyListeners();
    return total;
  }

  // -->> add to favorite bool
  bool _isFav = false;
  get isFav => _isFav;
  set isFav(value) {
    _isFav = value;
    notifyListeners();
  }

  // -->> to clear all data
  void onInit() {
    selectedDates = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)));    
    guests = 1;
    rooms = 1;
    notifyListeners();
  }
}
