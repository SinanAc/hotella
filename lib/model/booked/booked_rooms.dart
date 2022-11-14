import 'dart:convert';

BookedRoomsModel bookedRoomsModelFromJson(String str) =>
    BookedRoomsModel.fromJson(json.decode(str));

class BookedRoomsModel {
  BookedRoomsModel({
    this.success,
    this.completed,
    this.message,
  });

  bool? success;
  List<Completed>? completed;
  String? message;

  factory BookedRoomsModel.fromJson(Map<String, dynamic> json) =>
      BookedRoomsModel(
        success: json["success"],
        completed: List<Completed>.from(
          json["completed"].map(
            (x) => Completed.fromJson(x),
          ),
        ),
        message: json["message"], 
      );
}

class Completed {
  Completed({
    this.id,
    this.user,
    this.room,
    this.roomNumber,
    this.date,
    this.days,
    this.booingId,
    this.paymentType,
    this.isBooked,
    this.completed,
    this.cancel,
    this.v,
    this.property,
  });

  String? id;
  String? user;
  Room? room;
  int? roomNumber;
  Date? date;
  String? days;
  String? booingId;
  String? paymentType;
  bool? isBooked;
  bool? completed;
  bool? cancel;
  int? v;
  Property? property;

  factory Completed.fromJson(Map<String, dynamic> json) => Completed(
        id: json["_id"],
        user: json["user"],
        room: Room.fromJson(json["room"]),
        roomNumber: json["roomNumber"],
        date: Date.fromJson(json["Date"]),
        days: json["days"],
        booingId: json["bookingId"],
        paymentType: json["PaymentType"]??'PAY AT HOTEL',
        isBooked: json["isBooked"],
        completed: json["completed"],
        cancel: json["cancel"],
        v: json["__v"],
        property: Property.fromJson(json["property"]),
      );
}

class Date {
  Date({
    this.startDate,
    this.endDate,
  });

  DateTime? startDate;
  DateTime? endDate;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );
}

class Property {
  Property({
    this.id,
    this.propertyName,
    this.phoneNumber,
    this.propertyDetails,
    this.email,
    this.category,
    this.vendor,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.address,
    this.city,
    this.country,
    this.landmark,
    this.pincode,
    this.state,
    this.street,
  });

  String? id;
  String? propertyName;
  int? phoneNumber;
  String? propertyDetails;
  String? email;
  String? category;
  String? vendor;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? address;
  String? city;
  String? country;
  String? landmark;
  int? pincode;
  String? state;
  String? street;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["_id"],
        propertyName: json["property_name"],
        phoneNumber: json["phone_number"],
        propertyDetails: json["property_details"],
        email: json["email"],
        category: json["category"],
        vendor: json["vendor"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
        landmark: json["landmark"],
        pincode: json["pincode"],
        state: json["state"],
        street: json["street"],
      );
}

class Room {
  Room({
    this.id,
    this.property,
    this.category,
    this.vendor,
    this.amenities,
    this.roomName,
    this.roomType,
    this.view,
    this.isBlocked,
    this.bathroom,
    this.price,
    this.guest,
    this.noOfBed,
    this.checkinTime,
    this.checkoutTime,
    this.images,
    this.roomNumbers,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? property;
  String? category;
  String? vendor;
  List<dynamic>? amenities;
  String? roomName;
  String? roomType;
  String? view;
  bool? isBlocked;
  String? bathroom;
  int? price;
  int? guest;
  int? noOfBed;
  String? checkinTime;
  String? checkoutTime;
  List<List<Images>>? images;
  int? roomNumbers;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["_id"],
        property: json["property"],
        category: json["category"],
        vendor: json["vendor"],
        amenities: List<dynamic>.from(json["amenities"].map((x) => x)),
        roomName: json["room_name"],
        roomType: json["room_type"],
        view: json["view"],
        isBlocked: json["isBlocked"],
        bathroom: json["bathroom"],
        price: json["price"],
        guest: json["guest"],
        noOfBed: json["no_of_bed"],
        checkinTime: json["checkin_time"],
        checkoutTime: json["checkout_time"],
        images: List<List<Images>>.from(json["images"]
            .map((x) => List<Images>.from(x.map((x) => Images.fromJson(x))))),
        roomNumbers: json["roomNumbers"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Images {
  Images({
    this.url,
  });

  String? url;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
