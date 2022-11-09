class AllRoomsModel {
  AllRoomsModel(
      {this.id,
      this.property,
      this.category,
      this.vendor,
      this.amenities,
      this.roomName,
      this.roomType,
      this.quantity,
      this.view,
      this.isBlocked,
      this.bathroom,
      this.price,
      this.guest,
      this.noOfBed,
      this.checkinTime,
      this.checkoutTime,
      this.images,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.message});

  String? id;
  Property? property;
  Category? category;
  String? vendor;
  List<dynamic>? amenities;
  String? roomName;
  String? roomType;
  int? quantity;
  String? view;
  bool? isBlocked;
  String? bathroom;
  int? price;
  int? guest;
  int? noOfBed;
  String? checkinTime;
  String? checkoutTime;
  List<List<Images>>? images;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? message;

  factory AllRoomsModel.fromJson(Map<String, dynamic> json) => AllRoomsModel(
        id: json["_id"],
        property: Property.fromJson(json["property"]),
        category: Category.fromJson(json["category"]),
        vendor: json["vendor"],
        amenities: List<dynamic>.from(json["amenities"].map((x) => x)),
        roomName: json["room_name"],
        roomType: json["room_type"],
        quantity: json["quantity"],
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Category {
  Category({
    this.id,
    this.category,
    this.description,
    this.subCategory,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? category;
  String? description;
  List<dynamic>? subCategory;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        category: json["category"],
        description: json["description"],
        subCategory: List<dynamic>.from(json["sub_category"].map((x) => x)),
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
