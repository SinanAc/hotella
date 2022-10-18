import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/model/home/all_rooms_model/response.dart';
import 'package:premio_inn/services/home/get_all_rooms.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class HomeViewModel extends ChangeNotifier {
  // variables
  List<AllRoomssModel> allRooms = [];
  bool isLoading = false;

  // constructor to fetch hotel details in the initial stage
  HomeViewModel() {
    getAllRoom();
  }

  // function to fetch all rooms
  Future<void> getAllRoom() async {
    isLoading = true;
    notifyListeners();
    AllRoomsResponse? roomResponse = await GetAllRoomsService().getAllRooms();
     if (roomResponse == null) {
      ShowDialogs.popUp(
          'Please check your internet connection !',
          milliSec: 2000);
      _isLoadingFalse();
      return;
    } else if (roomResponse.isFailed == true) {
     ShowDialogs.popUp(
          roomResponse.errormessage ?? 'Something went wrong !!',
          milliSec: 2000);
      _isLoadingFalse();
      return;
    } else if(roomResponse.dataList != null){
      allRooms.clear();
      allRooms.addAll(roomResponse.dataList ?? []);
      _isLoadingFalse();
      return;
    }else{
      return;
    }
  }

  // function to make loading false
  void _isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }
}
