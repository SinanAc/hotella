class SignInResponseModel {
  SignInResponseModel({
    this.message,
    this.created,
    this.jwtKey,
  });

  String? message;
  bool? created;
  String? jwtKey;

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      SignInResponseModel(
        message: json["message"] ?? "",
        created: json["created"] ?? false,
        jwtKey: json["jwt_key"] ?? ""
      );
}
