class RoomAvailabilityResponseModel {
  bool? isAvailable;
  String? message;

  RoomAvailabilityResponseModel({
    this.isAvailable,
    this.message,
  });

  factory RoomAvailabilityResponseModel.fromJson(Map<String, dynamic> json) {
    return RoomAvailabilityResponseModel(
      isAvailable: json["success"],
      message: json["message"],
    );
  }
}
