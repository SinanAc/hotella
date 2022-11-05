import 'package:flutter/material.dart';
import 'package:premio_inn/model/booking/room_availability/request.dart';
import 'package:premio_inn/model/booking/room_availability/response.dart';
import 'package:premio_inn/services/booking/room_availability.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class RoomAvailabilityViewModel extends ChangeNotifier {
  // variables
  bool isLoading = false;
  // -->> function to check is room available or not
  Future<bool> isRoomAvailable(
      DateTimeRange dateRange, String hotelId, int rooms) async {
    isLoading = true;
    notifyListeners();
    final data = RoomAvailabiltyRequestModel(
      dateTimeRange: dateRange,
      hotelId: hotelId,
      numberOfRooms: rooms,
    );
    final RoomAvailabilityResponseModel? isRoomAvailableResponse= await RoomAvailabilityService().isRoomAvailabileService(data);
    if(isRoomAvailableResponse==null){
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp('Something went wrong !!');
      return false;  
    }else if (isRoomAvailableResponse.isAvailable==false) {
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(isRoomAvailableResponse.message??'Rooms are not available on the selected range. Please try with other dates.',color: Colors.black87);
      return false;  
    }else if (isRoomAvailableResponse.isAvailable==true) {
      isLoading = false;
      notifyListeners();
      return true;  
    }else{
      isLoading = false;
      notifyListeners();
      ShowDialogs.popUp(isRoomAvailableResponse.message??'Something went wrong !!');
      return false;  
    }
  }
}
