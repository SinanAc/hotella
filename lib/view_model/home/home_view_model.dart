import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms.dart';
import 'package:premio_inn/model/home/response.dart';
import 'package:premio_inn/services/dio/internet_checker.dart';
import 'package:premio_inn/services/home/get_all_rooms.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/screens/category/category_screen.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class HomeViewModel extends ChangeNotifier {
  // =========>>>>>  VARIABLES  <<<<<==========
  List<AllRoomsModel> allRooms = [];
  bool isLoading = false;
  List<String> allCities = [];
  List<AllRoomsModel> categoryWiseList = [];

  // =========>>>>>  CONSTRUCTOR TO SET INITIAL VALUES  <<<<<==========
  HomeViewModel() {
    getAllRoom();
  }

  // =========>>>>>  TO FETCH ALL PROPERTIES  <<<<<==========
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

  // =========>>>>>  TO GET ALL HOTELS  <<<<<==========
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

  // =========>>>>>  TO GET ALL HOME STAYS  <<<<<==========
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

  // =========>>>>>  TO GET ALL RESORTS  <<<<<==========
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

  // =========>>>>>  TO GET ALL AVAILABLE CITIES  <<<<<==========
  void fetchAllCities() {
    allCities.clear();
    ////  --->>>  loop to get every cities added
    for (int i = 0; i < allRooms.length; i++) {
      allCities.add(allRooms[i].property?.city?.trim() ?? '');
    }
    ////  --->>>   to remove duplicate cities
    allCities = allCities.toSet().toList();
    notifyListeners();
  }

  // =========>>>>>  TO MAKE LOADING FALSE  <<<<<==========
  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

}
