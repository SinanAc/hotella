class BookingResponseModel {
  BookingResponseModel({
    this.success,
    this.response,
    this.message,
  });

  bool? success;
  Responses? response;
  String? message;

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) =>
      BookingResponseModel(
        success: json["success"],
        response: Responses.fromJson(json["response"]),
      );
}

class Responses {
  Responses({
    this.user,
    this.room,
    this.roomNumber,
    this.days,
    this.isBooked,
    this.completed,
    this.cancel,
    this.id,
  });

  String? user;
  String? room;
  int? roomNumber;
  String? days;
  bool? isBooked;
  bool? completed;
  bool? cancel;
  String? id;

  factory Responses.fromJson(Map<String, dynamic> json) => Responses(
        user: json["user"],
        room: json["room"],
        roomNumber: json["roomNumber"],
        days: json["days"],
        isBooked: json["isBooked"],
        completed: json["completed"],
        cancel: json["cancel"],
        id: json["_id"],
      );
}
