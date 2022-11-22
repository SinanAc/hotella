class AllRoomsModel {
  AllRoomsModel({
    this.id,
    this.property,
    this.category,
    this.isBlocked,
    this.bathroom,
    this.price,
    this.guest,
    this.checkinTime,
    this.checkoutTime,
    this.images,
    this.message,
  });

  String? id;
  Property? property;
  Category? category;
  bool? isBlocked;
  String? bathroom;
  int? price;
  int? guest;
  String? checkinTime;
  String? checkoutTime;
  List<List<Images>>? images;
  String? message;

  factory AllRoomsModel.fromJson(Map<String, dynamic> json) => AllRoomsModel(
        id: json["_id"],
        property: Property.fromJson(json["property"]),
        category: Category.fromJson(json["category"]),
        isBlocked: json["isBlocked"],
        bathroom: json["bathroom"],
        price: json["price"],
        guest: json["guest"],
        checkinTime: json["checkin_time"],
        checkoutTime: json["checkout_time"],
        images: List<List<Images>>.from(json["images"]
            .map((x) => List<Images>.from(x.map((x) => Images.fromJson(x))))),
      );
}

class Category {
  Category({
    this.category,
  });

  String? category;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        category: json["category"],
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
}

class Property {
  Property({
    this.propertyName,
    this.phoneNumber,
    this.propertyDetails,
    this.email,
    this.category,
    this.address,
    this.city,
  });

  String? propertyName;
  int? phoneNumber;
  String? propertyDetails;
  String? email;
  String? category;
  String? address;
  String? city;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        propertyName: json["property_name"],
        phoneNumber: json["phone_number"],
        propertyDetails: json["property_details"],
        email: json["email"],
        category: json["category"],
        address: json["address"],
        city: json["city"],
      );
}
