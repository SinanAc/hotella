import 'dart:convert';

List<BookedRoomsModel> bookedRoomsModelFromJson(String str) =>
    List<BookedRoomsModel>.from(
        json.decode(str).map((x) => BookedRoomsModel.fromJson(x)));

class BookedRoomsModel {
  BookedRoomsModel({
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
    this.count,
  });

  String? id;
  Property? property;
  CategoryClass? category;
  Vendor? vendor;
  List<dynamic>? amenities;
  RoomName? roomName;
  RoomType? roomType;
  View? view;
  bool? isBlocked;
  Bathroom? bathroom;
  int? price;
  int? guest;
  int? noOfBed;
  CheckinTime? checkinTime;
  CheckoutTime? checkoutTime;
  List<List<Images>>? images;
  int? roomNumbers;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? count;

  factory BookedRoomsModel.fromJson(Map<String, dynamic> json) =>
      BookedRoomsModel(
        id: json["_id"],
        property: Property.fromJson(json["property"]),
        category: CategoryClass.fromJson(json["category"]),
        vendor: vendorValues.map?[json["vendor"]],
        amenities: List<dynamic>.from(json["amenities"].map((x) => x)),
        roomName: roomNameValues.map?[json["room_name"]],
        roomType: roomTypeValues.map?[json["room_type"]],
        view: viewValues.map?[json["view"]],
        isBlocked: json["isBlocked"],
        bathroom: bathroomValues.map?[json["bathroom"]],
        price: json["price"],
        guest: json["guest"],
        noOfBed: json["no_of_bed"],
        checkinTime: checkinTimeValues.map?[json["checkin_time"]],
        checkoutTime: checkoutTimeValues.map?[json["checkout_time"]],
        images: List<List<Images>>.from(json["images"]
            .map((x) => List<Images>.from(x.map((x) => Images.fromJson(x))))),
        roomNumbers: json["roomNumbers"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        count: json["count"],
      );
}

enum Bathroom { yes }

final bathroomValues = EnumValues({"Yes": Bathroom.yes});

class CategoryClass {
  CategoryClass({
    this.id,
    this.category,
    this.description,
    this.subCategory,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Id? id;
  CategoryEnum? category;
  String? description;
  List<dynamic>? subCategory;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory CategoryClass.fromJson(Map<String, dynamic> json) => CategoryClass(
        id: idValues.map?[json["_id"]],
        category: categoryEnumValues.map?[json["category"]],
        description: json["description"],
        subCategory: List<dynamic>.from(json["sub_category"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

enum CategoryEnum { hotels, homeStay }

final categoryEnumValues = EnumValues(
    {"HomeStay": CategoryEnum.homeStay, "Hotels": CategoryEnum.hotels});

enum Id { idValue1, idValue2 }

final idValues = EnumValues({
  "635282f8257b26414f28407d": Id.idValue1,
  "6361008497430c0043f9dcb5": Id.idValue2
});

enum CheckinTime { checkIn }

final checkinTimeValues = EnumValues({"11AM": CheckinTime.checkIn});

enum CheckoutTime { checkOut }

final checkoutTimeValues = EnumValues({"12PM": CheckoutTime.checkOut});

class Images {
  Images({
    this.url,
  });

  String? url;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        url: json["url"],
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
  Id? category;
  Vendor? vendor;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? address;
  String? city;
  Country? country;
  String? landmark;
  int? pincode;
  State? state;
  String? street;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["_id"],
        propertyName: json["property_name"],
        phoneNumber: json["phone_number"],
        propertyDetails: json["property_details"],
        email: json["email"],
        category: idValues.map?[json["category"]],
        vendor: vendorValues.map?[json["vendor"]],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        address: json["address"],
        city: json["city"],
        country: countryValues.map?[json["country"]],
        landmark: json["landmark"],
        pincode: json["pincode"],
        state: stateValues.map?[json["state"]],
        street: json["street"],
      );
}

enum Country { india, countryIndia }

final countryValues =
    EnumValues({"India ": Country.countryIndia, "India": Country.india});

enum State { kerala, stateKerala }

final stateValues =
    EnumValues({"Kerala": State.kerala, " Kerala": State.stateKerala});

enum Vendor { theVendorValue }

final vendorValues =
    EnumValues({"633f1b8e5849c007e8204ae4": Vendor.theVendorValue});

enum RoomName {kingRoom, suitRoom, deluxRoom}

final roomNameValues = EnumValues({
  "Delux super": RoomName.deluxRoom,
  "King Room": RoomName.kingRoom,
  "Suite Room": RoomName.suitRoom
});

enum RoomType { doubleBedroom, doubleSingle, singleRoom }

final roomTypeValues = EnumValues({
  "Double Bedroom": RoomType.doubleBedroom,
  "Double Bedroom & Single Room": RoomType.doubleSingle,
  "Single Room": RoomType.singleRoom
});

enum View { cityView, oceanView, mountainView }

final viewValues = EnumValues({
  "City View": View.cityView,
  "Mountain View": View.mountainView,
  "Ocean View ": View.oceanView
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map?.map((k, v) => MapEntry(v, k));
    return reverseMap ?? {};
  }
}
