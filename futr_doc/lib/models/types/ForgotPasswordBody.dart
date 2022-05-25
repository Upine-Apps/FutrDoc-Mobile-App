class ForgotPasswordBody {
  String username;
  String code;
  String password;

  ForgotPasswordBody(
      {required this.username, required this.code, required this.password});

  Object toJson() => {
        'username': '+1' + username,
        'code': code,
        'password': password,
      };
}
