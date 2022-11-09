class OtpResponseModel {
  String? message;
  bool? created;
  String? phone;

  OtpResponseModel({
    this.message,
    this.created,
    this.phone,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      OtpResponseModel(
          message: json["message"] ?? '',
          created: json["created"] ?? false,
          phone: json["phone"] ?? '');
}
