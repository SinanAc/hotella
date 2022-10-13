class SignUpResponseModel {
   String? message;
   bool? created;
   String? jwtKey;

  SignUpResponseModel({
    this.message,
    this.created,
    this.jwtKey,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
        message: json["message"] ?? "",
        created: json["created"] ?? false,
        jwtKey: json["jwt_key"] ?? ""
      );
}
