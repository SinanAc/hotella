BookedRoomsModel bookedRoomsModelFromJson(String str) => BookedRoomsModel.fromJson(json.decode(str));

String bookedRoomsModelToJson(BookedRoomsModel data) => json.encode(data.toJson());

class BookedRoomsModel {
    BookedRoomsModel({
        this.id,
        this.user,
        this.room,
        this.roomNumber,
        this.date,
        this.days,
        this.isBooked,
        this.completed,
        this.cancel,
        this.v,
        this.property,
    });

    String id;
    String user;
    Room room;
    int roomNumber;
    Date date;
    String days;
    bool isBooked;
    bool completed;
    bool cancel;
    int v;
    Property property;

    factory BookedRoomsModel.fromJson(Map<String, dynamic> json) => BookedRoomsModel(
        id: json["_id"],
        user: json["user"],
        room: Room.fromJson(json["room"]),
        roomNumber: json["roomNumber"],
        date: Date.fromJson(json["Date"]),
        days: json["days"],
        isBooked: json["isBooked"],
        completed: json["completed"],
        cancel: json["cancel"],
        v: json["__v"],
        property: Property.fromJson(json["property"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "room": room.toJson(),
        "roomNumber": roomNumber,
        "Date": date.toJson(),
        "days": days,
        "isBooked": isBooked,
        "completed": completed,
        "cancel": cancel,
        "__v": v,
        "property": property.toJson(),
    };
}

class Date {
    Date({
        this.startDate,
        this.endDate,
    });

    DateTime startDate;
    DateTime endDate;

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
    );

    Map<String, dynamic> toJson() => {
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
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

    String id;
    String propertyName;
    int phoneNumber;
    String propertyDetails;
    String email;
    String category;
    String vendor;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String address;
    String city;
    String country;
    String landmark;
    int pincode;
    String state;
    String street;

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

    Map<String, dynamic> toJson() => {
        "_id": id,
        "property_name": propertyName,
        "phone_number": phoneNumber,
        "property_details": propertyDetails,
        "email": email,
        "category": category,
        "vendor": vendor,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "address": address,
        "city": city,
        "country": country,
        "landmark": landmark,
        "pincode": pincode,
        "state": state,
        "street": street,
    };
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

    String id;
    String property;
    String category;
    String vendor;
    List<dynamic> amenities;
    String roomName;
    String roomType;
    String view;
    bool isBlocked;
    String bathroom;
    int price;
    int guest;
    int noOfBed;
    String checkinTime;
    String checkoutTime;
    List<List<Image>> images;
    int roomNumbers;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

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
        images: List<List<Image>>.from(json["images"].map((x) => List<Image>.from(x.map((x) => Image.fromJson(x))))),
        roomNumbers: json["roomNumbers"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "property": property,
        "category": category,
        "vendor": vendor,
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "room_name": roomName,
        "room_type": roomType,
        "view": view,
        "isBlocked": isBlocked,
        "bathroom": bathroom,
        "price": price,
        "guest": guest,
        "no_of_bed": noOfBed,
        "checkin_time": checkinTime,
        "checkout_time": checkoutTime,
        "images": List<dynamic>.from(images.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "roomNumbers": roomNumbers,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Image {
    Image({
        this.url,
    });

    String url;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
