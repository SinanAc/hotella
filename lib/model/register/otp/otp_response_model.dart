class OtpResponseModel {
  bool? success;
  String? phone;
  String? message;

  OtpResponseModel({
    this.success,
    this.phone,
    this.message,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      OtpResponseModel(
        success: json["success"] ?? false,
        phone: json["phone"] ?? '',
        message: json["message"] ?? '',
      );
}
