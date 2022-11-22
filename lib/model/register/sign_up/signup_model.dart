class SignUpModel {
  final String? name;
  final String? phone;
  final String? email;
  final String? password;

  SignUpModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic>? toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      };
}
