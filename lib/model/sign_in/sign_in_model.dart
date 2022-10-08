class SignInModel {
  final String email;
  final String password;

  SignInModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}