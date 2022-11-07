class RoomAvailabilityResponseModel {
  bool? isSuccess;
  String? bookingId;

  RoomAvailabilityResponseModel({
    this.isSuccess,
    this.bookingId,
  });

  factory RoomAvailabilityResponseModel.fromJson(Map<String, dynamic> json) {
    return RoomAvailabilityResponseModel(
      isSuccess: json["success"],
      bookingId: json["bookingId"],
    );
  }
}