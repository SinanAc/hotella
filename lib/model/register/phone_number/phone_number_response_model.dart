class PhoneNumberResponseModel {
  String? message;
  bool? created;
  String? hash;

  PhoneNumberResponseModel({
    this.message,
    this.created,
    this.hash,
  });

  factory PhoneNumberResponseModel.fromJson(Map<String, dynamic> json) =>
      PhoneNumberResponseModel(
          message: json["message"] ?? '',
          created: json["created"] ?? false,
          hash: json["hash"] ?? '');
}
