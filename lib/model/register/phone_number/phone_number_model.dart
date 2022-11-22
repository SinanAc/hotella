class PhoneNumberModel {
  final String? phoneNumber;

  PhoneNumberModel({
    required this.phoneNumber,
  });

  Map<String, dynamic>? toJson() => {
        "phone_number": phoneNumber,
      };
}
