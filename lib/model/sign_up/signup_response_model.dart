class SignUpResponseModel {
   String? message;
   String? id;
   String? token;

  SignUpResponseModel({
    this.message,
    this.id,
    this.token,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
        message: json["message"] ?? "",
        id: json["userId"] ?? "",
        token: json["token"] ?? ""
      );
}
