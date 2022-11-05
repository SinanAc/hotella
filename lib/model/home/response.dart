import 'package:premio_inn/model/home/all_rooms.dart';

class AllRoomsResponse {
  AllRoomsResponse({
    this.dataList,
    this.errormessage,
    this.isFailed,
  });

  List<AllRoomsModel>? dataList;
  String? errormessage;
  bool? isFailed;

  factory AllRoomsResponse.fromJson(Map<String, dynamic> json){
    return AllRoomsResponse(
        dataList:  (json as List).map((e) {
          return AllRoomsModel.fromJson(e);
        }).toList(),
        isFailed: false,
      );
  }

}