import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/model/home/all_rooms_model/response.dart';
import 'package:premio_inn/services/home/get_all_rooms.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class HomeViewModel extends ChangeNotifier {
  // variables
  List<AllRoomssModel> allRooms = [];
  bool isLoading = false;

  // function to fetch all rooms
  Future<List<AllRoomssModel>> getAllRooms(context) async {
    isLoading = true;
    notifyListeners();
    AllRoomsResponse? roomResponse = await GetAllRoomsService().getAllRooms();
    if (roomResponse == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          ShowDialogs.errorPopUp('Please check your internet connection !',seconds: 2));
      _isLoadingFalse();
      return [];
    } else if (roomResponse.isFailed == true) {
      ScaffoldMessenger.of(context).showSnackBar(ShowDialogs.errorPopUp(
          roomResponse.errormessage ?? 'Something went wrong !!',seconds: 2));
      _isLoadingFalse();
      return [];
    } else {
      allRooms.clear();
      allRooms.addAll(roomResponse.dataList ?? []);
      _isLoadingFalse();
      return allRooms;
    }
  }

  // function to make loading false
  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }
}
