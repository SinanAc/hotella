class PhoneNumberResponseModel {
  String? message;
  bool? success;
  String? hash;

  PhoneNumberResponseModel({
    this.message,
    this.success,
    this.hash,
  });

  factory PhoneNumberResponseModel.fromJson(Map<String, dynamic> json) =>
      PhoneNumberResponseModel(
          message: json["message"] ?? '',
          success: json["success"] ?? false,
          hash: json["hash"] ?? '');
}
