class PhoneNumberResponseModel {
  bool? success;
  String? hash;
  String? message;

  PhoneNumberResponseModel({
    this.success,
    this.hash,
    this.message,
  });

  factory PhoneNumberResponseModel.fromJson(Map<String, dynamic> json) =>
      PhoneNumberResponseModel(
          success: json["success"] ?? false,
          hash: json["hash"] ?? '',
          message: json["message"] ?? '');
}
