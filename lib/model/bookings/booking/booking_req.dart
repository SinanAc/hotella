import 'package:flutter/material.dart';

class BookingRequestModel {
  DateTimeRange dateTimeRange;
  int numberOfRooms;
  String hotelId;

  BookingRequestModel(
      {required this.dateTimeRange,
      required this.numberOfRooms,
      required this.hotelId});

  Map<String, dynamic> toJson() {
    return {
      "hotelId": hotelId,
      "startDate": dateTimeRange.start.toIso8601String(),
      "endDate": dateTimeRange.end.toIso8601String(),
      "roomsCount": numberOfRooms
    };
  }
}
