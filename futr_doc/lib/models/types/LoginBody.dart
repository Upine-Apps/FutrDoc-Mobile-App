class LoginBody {
  String username;
  String password;

  LoginBody({required this.username, required this.password});

  Object toJson() => {
        'username': '+1' + username,
        'password': password,
      };
}
