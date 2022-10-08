class SignInResponseModel {
  SignInResponseModel({
    required this.message,
    this.token,
  });

  String message;
  String? token;

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) => SignInResponseModel(
        message: json["message"] ?? "",
        token: json["token"] ?? "No token",
      );
}