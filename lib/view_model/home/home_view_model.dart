import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/model/home/all_rooms_model/response.dart';
import 'package:premio_inn/services/home/get_all_rooms.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/screens/category/category_screen.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';

class HomeViewModel extends ChangeNotifier {
  // -->> variables
  List<AllRoomsModel> allRooms = [];
  bool isLoading = false;
  String userLocation = '';
  bool isLocationLoading = false;
  List<String> allCities = [];

  // -->> constructor to fetch all the in the initial stage
  HomeViewModel() {
    initMethod();
  }

  // -->> function to fetch all rooms
  Future<void> getAllRoom() async {
    isLoading = true;
    notifyListeners();
    AllRoomsResponse? roomResponse = await GetAllRoomsService().getAllRooms();
    if (roomResponse == null) {
      ShowDialogs.popUp('Please check your internet connection !');
      _isLoadingFalse();
      return;
    } else if (roomResponse.isFailed == true) {
      ShowDialogs.popUp(roomResponse.errormessage ?? 'Something went wrong !!');
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
  }

  // -->> fuction to get user's current location
  Future<void> getUserLocation() async {
    isLocationLoading = true;
    notifyListeners();
    final bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _isLocationLoadingFalse();
        return;
      } else if (permission == LocationPermission.deniedForever) {
        ShowDialogs.popUp(
            'Location permission denied, please enable from settings');
        _isLocationLoadingFalse();
        return;
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        await placemarkFromCoordinates(position.latitude, position.longitude)
            .then((List<Placemark> placemarks) {
          Placemark place = placemarks[0];
          userLocation =
              '${place.subAdministrativeArea}, ${place.administrativeArea}';
          notifyListeners();
        });
        _isLocationLoadingFalse();
      } else {
        _isLocationLoadingFalse();
        return;
      }
    } else {
      // 'Please allow location from settings to get your current location'
      // await Geolocator.openAppSettings();
      // ShowDialogs.dialogBox(
      //   messege: 'Please allow location access from settings to get your current location', 
      //   goOn: ()async{
      //     await Geolocator.openAppSettings();
      //   });
      ShowDialogs.popUp(
            'Location permission denied, please enable from settings');
      _isLocationLoadingFalse();
      return;
    }
  }

  // -->> function to work when HOTEL category button is clicked
  void onHotelButton() {
    if (allRooms.isEmpty) {
      ShowDialogs.popUp('Properties are not availabe at this moment !!');
      return;
    } else {
      List<AllRoomsModel> hotelList = [];
      for (int i = 0; i < allRooms.length; i++) {
        if (allRooms[i].category?.category?.toLowerCase().trim() == 'hotels') {
          hotelList.add(allRooms[i]);
        }
      }
      hotelList.isEmpty
          ? ShowDialogs.popUp('Hotels are not availabe at this moment !!')
          : Navigations.push(
              CategoryScreen(categoryName: 'Hotels', roomsList: hotelList),
            );
    }
  }

  // -->> function to work when HOME_STAY category button is clicked
  void onHomeStayButton() {
    if (allRooms.isEmpty) {
      ShowDialogs.popUp('Properties are not availabe at this moment !!');
      return;
    } else {
      List<AllRoomsModel> homeStayList = [];
      for (int i = 0; i < allRooms.length; i++) {
        if (allRooms[i].category?.category?.toLowerCase().trim() ==
            'homestay') {
          homeStayList.add(allRooms[i]);
        }
      }
      homeStayList.isEmpty
          ? ShowDialogs.popUp('Home Stays are not availabe at this moment !!')
          : Navigations.push(
              CategoryScreen(
                  categoryName: 'Home Stays', roomsList: homeStayList),
            );
    }
  }

  // -->> function to work when RESORT category button is clicked
  void onResortButton() {
    if (allRooms.isEmpty) {
      ShowDialogs.popUp('Properties are not availabe at this moment !!');
      return;
    } else {
      List<AllRoomsModel> resortList = [];
      for (int i = 0; i < allRooms.length; i++) {
        if (allRooms[i].category?.category?.toLowerCase().trim() == 'resort') {
          resortList.add(allRooms[i]);
        }
      }
      resortList.isEmpty
          ? ShowDialogs.popUp('Resorts are not availabe at this moment !!')
          : Navigations.push(
              CategoryScreen(categoryName: 'Resorts', roomsList: resortList),
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

  void _isLocationLoadingFalse() {
    isLocationLoading = false;
  }

  Future<void> initMethod() async {
    await getUserLocation().then((value) {
      getAllRoom();
    });
  }
}
