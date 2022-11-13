import 'package:flutter/material.dart';

class BookingRequestModel {
  String hotelId;
  int rooms;
  DateTimeRange dateTimeRange;

  BookingRequestModel({
    required this.hotelId,
    required this.rooms,
     required this.dateTimeRange,

  });

  Map<String, dynamic> toJson() {
    return {
      "hotel": hotelId,
      "start": dateTimeRange.start.toIso8601String(),
      "room": rooms,
      "end": dateTimeRange.end.toIso8601String(),
      };
  }
}