import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class CategoryViewModel extends ChangeNotifier {
  // constructor
  CategoryViewModel() {
    dropdownValue = null;
    notifyListeners();
  }

  // variables
  String? dropdownValue;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          value: "Low to high",
          child: TextWidget(text: "Low to high", color: Colors.grey.shade300)),
      DropdownMenuItem(
          value: "High to low",
          child: TextWidget(text: "High to low", color: Colors.grey.shade300)),
    ];
    return menuItems;
  }

// -->> dropdown onchanged
  void onDropdownChanged(
      String? val, List<AllRoomsModel> roomList, BuildContext ctx) {
    dropdownValue = val;
    final homePro = Provider.of<HomeViewModel>(ctx, listen: false);
    roomList.sort((a, b) => (a.price as int).compareTo(b.price as int));
    List<AllRoomsModel> tempList = [];
    tempList.addAll(roomList);
    homePro.categoryWiseList.clear();
    if (val == 'Low to high') {
      homePro.categoryWiseList.addAll(tempList);
      notifyListeners();
      return;
    } else {
      homePro.categoryWiseList.addAll(tempList.reversed);
      notifyListeners();
    }
  }
}
