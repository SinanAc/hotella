class SignInResponseModel {
  SignInResponseModel({
    this.isSuccess,
    this.profile,
    this.message,
  });

  bool? isSuccess;
  Profile? profile;
  String? message;

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      SignInResponseModel(
          isSuccess: json["success"],
          profile: Profile.fromJson(json["profile"]),
          message: json["message"]);
}

class Profile {
  Profile({
    this.name,
    this.email,
    this.phone,
    required this.token,
  });

  String? name;
  String? email;
  String? phone;
  String? token;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        token: json["token"] ?? "",
      );
}
