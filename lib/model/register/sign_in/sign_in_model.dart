class SignInModel {
  final String phoneOrEmail;
  final String password;

  SignInModel({
    required this.phoneOrEmail,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": phoneOrEmail,
        "password": password,
      };
}
