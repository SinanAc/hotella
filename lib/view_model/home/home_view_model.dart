import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/model/home/all_rooms_model/response.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/services/home/get_all_rooms.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/screens/category/category_screen.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class HomeViewModel extends ChangeNotifier {
  // -->> variables
  List<AllRoomsModel> allRooms = [];
  bool isLoading = false;
  List<String> allCities = [];
  List<AllRoomsModel> categoryWiseList = [];
  // -->> constructor to fetch all the in the initial stage
  HomeViewModel() {
    getAllRoom();
  }

  // -->> function to fetch all rooms
  Future<void> getAllRoom() async {
    if (await internetCheck()) {
      isLoading = true;
      notifyListeners();
      AllRoomsResponse? roomResponse = await GetAllRoomsService().getAllRooms();
      if (roomResponse == null) {
        ShowDialogs.popUp('Please check your internet connection !');
        _isLoadingFalse();
        return;
      } else if (roomResponse.isFailed == true) {
        ShowDialogs.popUp(
            roomResponse.errormessage ?? 'Something went wrong !!');
        _isLoadingFalse();
        return;
      } else if (roomResponse.dataList != null) {
        allRooms.clear();
        allRooms.addAll(roomResponse.dataList ?? []);
        _isLoadingFalse();
        return;
      } else {
        return;
      }
    } else {
      ShowDialogs.popUp('Please check your internet connection !');
    }
  }

  // -->> function to work when HOTEL category button is clicked
  void onHotelButton() {
    if (allRooms.isEmpty) {
      ShowDialogs.popUp('Properties are not availabe at this moment !!');
      return;
    } else {
      categoryWiseList.clear();
      for (int i = 0; i < allRooms.length; i++) {
        if (allRooms[i].category?.category?.toLowerCase().trim() == 'hotels') {
          categoryWiseList.add(allRooms[i]);
        }
      }
      categoryWiseList.isEmpty
          ? ShowDialogs.popUp('Hotels are not availabe at this moment !!')
          : Navigations.push(
              const CategoryScreen(categoryName: 'Hotels'),
            );
    }
  }

  // -->> function to work when HOME_STAY category button is clicked
  void onHomeStayButton() {
    if (allRooms.isEmpty) {
      ShowDialogs.popUp('Properties are not availabe at this moment !!');
      return;
    } else {
      categoryWiseList.clear();
      for (int i = 0; i < allRooms.length; i++) {
        if (allRooms[i].category?.category?.toLowerCase().trim() ==
            'homestay') {
          categoryWiseList.add(allRooms[i]);
        }
      }
      categoryWiseList.isEmpty
          ? ShowDialogs.popUp('Home Stays are not availabe at this moment !!')
          : Navigations.push(
              const CategoryScreen(
                  categoryName: 'Home Stays'),
            );
    }
  }

  // -->> function to work when RESORT category button is clicked
  void onResortButton() {
    if (allRooms.isEmpty) {
      ShowDialogs.popUp('Properties are not availabe at this moment !!');
      return;
    } else {
      categoryWiseList.clear();
      for (int i = 0; i < allRooms.length; i++) {
        if (allRooms[i].category?.category?.toLowerCase().trim() == 'resort') {
          categoryWiseList.add(allRooms[i]);
        }
      }
      categoryWiseList.isEmpty
          ? ShowDialogs.popUp('Resorts are not availabe at this moment !!')
          : Navigations.push(
              const CategoryScreen(categoryName: 'Resorts'),
            );
    }
  }

  // -->> function to fetch all available cities
  void fetchAllCities() {
    allCities.clear();
    //// loop to get every cities added
    for (int i = 0; i < allRooms.length; i++) {
      allCities.add(allRooms[i].property?.city?.trim() ?? '');
    }
    //// to remove duplicate cities
    allCities = allCities.toSet().toList();
    notifyListeners();
  }

  // -->> function to make loading false
  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

}
