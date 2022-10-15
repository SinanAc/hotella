import 'package:flutter/cupertino.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/services/home/get_all_rooms.dart';

class HomeViewModel extends ChangeNotifier {
  // variables
  List<AllRoomssModel> allRooms = [];
  bool isLoading = false;

  // function to fetch all rooms 
  Future<List<AllRoomssModel>> getAllRooms(context)async{
    isLoading = true;
    notifyListeners();
    List<AllRoomssModel>? rooms = await GetAllRoomsService().getALlRooms();
    if(rooms==null){
      return allRooms;
    }else{
      allRooms.clear();
      allRooms.addAll(rooms);
          _isLoadingFalse();
    return allRooms;
    }
  }

  // function to make loading false
  void _isLoadingFalse(){
    isLoading = false;
  }

}