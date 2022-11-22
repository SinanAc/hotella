class CancelResponseModel {
  CancelResponseModel({
    this.success,
    this.message,
  });

  bool? success;
  String? message;

  factory CancelResponseModel.fromJson(Map<String, dynamic> json) =>
      CancelResponseModel(
        success: json["success"],
      );
}
