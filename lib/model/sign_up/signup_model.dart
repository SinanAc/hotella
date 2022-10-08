class SignUpModel {
  final String? email;
  final String? name;
  final String? password;
  final String? confirmPassword;
  final String? role;

  SignUpModel(
      {required this.email,
      required this.name,
      required this.password,
      required this.confirmPassword,
      required this.role
      });

  Map<String, dynamic>? toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": password,
        "role": role
      };

}
