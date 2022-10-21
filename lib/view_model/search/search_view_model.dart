import 'package:flutter/cupertino.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class SearchViewModel extends ChangeNotifier {
  // variables
  TextEditingController searchTextController = TextEditingController();
  List<AllRoomssModel> searchResults = [];

  // -->> function to get search results
  void getSearchResults (String city,BuildContext context) {
    searchResults.clear();
    final List<AllRoomssModel> allRooms =
        context.read<HomeViewModel>().allRooms;
    for(int i = 0; i < allRooms.length; i++) { 
      if(allRooms[i].property?.city?.trim()==city){

      }
    }   

  }
}
