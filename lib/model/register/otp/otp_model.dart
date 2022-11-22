class OtpModel {
  final String? otp;
  final String? hash;

  OtpModel({
    required this.otp,
    required this.hash,
  });

  Map<String, dynamic>? toJson() => {
        "otp": otp,
        "hash": hash,
      };
}
