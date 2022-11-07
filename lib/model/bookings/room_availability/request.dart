import 'package:flutter/material.dart';

class RoomAvailabiltyRequestModel {
  String hotelId;
  DateTimeRange dateTimeRange;
  int numberOfRooms;

  RoomAvailabiltyRequestModel({
    required this.dateTimeRange,
    required this.hotelId,
    required this.numberOfRooms,
  });

  Map<String, dynamic> toJson() {
    return {
      "hotelId": hotelId,
      "startDate": dateTimeRange.start.toIso8601String(),
      "endDate": dateTimeRange.end.toIso8601String(),
      "roomsCount": numberOfRooms
    };
  }
}
