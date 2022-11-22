class CompleteBookingResponse {
  CompleteBookingResponse({
    this.success,
    this.message,
  });
  bool? success;
  String? message;

  factory CompleteBookingResponse.fromJson(Map<String, dynamic> json) =>
      CompleteBookingResponse(
        success: json["success"],
      );
}
