import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms.dart';

class SearchViewModel extends ChangeNotifier {
  // variables
  TextEditingController searchTextController = TextEditingController();
  List<AllRoomsModel> searchResultList = [];
  List<String> searchCityList = [];

  // -->> function to get searching cities
  void runSearchFilter(
      {required String enteredKeyword, required List<String> cities}) {
    if (enteredKeyword.isEmpty) {
      return;
    } else {
      searchCityList = cities
          .where(
            (element) => element.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }
    notifyListeners();
  }

  // -->> function to get search results
  void getSearchResults(
      {required String city, required List<AllRoomsModel> allRooms}) {
    searchResultList.clear();
    for (int i = 0; i < allRooms.length; i++) {
      if (allRooms[i].property?.city?.trim() == city) {
        searchResultList.add(allRooms[i]);
      }
    }
    notifyListeners();
  }
}
