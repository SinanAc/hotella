class BookingRequestModel {
  String hotelId;
  int rooms;

  BookingRequestModel({
    required this.hotelId,
    required this.rooms,
  });

  Map<String, dynamic> toJson() {
    return {"hotel": hotelId, "room": rooms};
  }
}
