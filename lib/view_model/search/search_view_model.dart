import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms.dart';

class SearchViewModel extends ChangeNotifier {
  // ==========>>>>>  VARIABLES  <<<<<==========
  TextEditingController searchTextController = TextEditingController();
  List<AllRoomsModel> searchResultList = [];
  List<String> searchCityList = [];

  // ==========>>>>>  TO GET SEARCHING CITIES  <<<<<==========
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

  // ==========>>>>>  SEARCH RESULTS  <<<<<==========
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
