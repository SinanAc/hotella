import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class HotelViewModel extends ChangeNotifier {
  // constructor to get initial values
  HotelViewModel() {
    selectedDates = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)));
    guests = 2;
    notifyListeners();
  }
  // vaiables
  DateTimeRange selectedDates = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 1)));
  int guests = 2;
  final Icon notFavIcon = Icon(
    Icons.favorite_border,
    size: 32,
    color: Colors.grey.shade600,
  );
  final Icon favIcon =
      const Icon(Icons.favorite_outlined, color: KColors.kRedColor, size: 32);
  final PageController pController = PageController();

  //function to select date range
  Future<void> selectDate(BuildContext ctx) async {
    selectedDates = await showDateRangePicker(
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDateRange: selectedDates,
          context: ctx,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
          confirmText: 'Confirm',
          cancelText: 'Cancel',
          // builder: (context, child) {
          //   return Padding(
          //     padding: const EdgeInsets.all(40.0),
          //     child: Scaffold(
          //       // height: MediaQuery.of(ctx).size.height/1.4,
          //       // width: double.infinity,
          //       appBar: AppBar(
          //         toolbarHeight: 100,
          //       ),
          //     ),
          //   );
          // },
        ) ??
        selectedDates;
    notifyListeners();
  }

  // add to favorite bool
  bool _isFav = false;
  get isFav => _isFav;
  set isFav(value) {
    _isFav = value;
    notifyListeners();
  }
}
