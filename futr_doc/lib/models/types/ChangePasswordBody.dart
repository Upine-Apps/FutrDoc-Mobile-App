class ChangePasswordBody {
  String username;
  String oldPassword;
  String newPassword;

  ChangePasswordBody(
      {required this.username,
      required this.oldPassword,
      required this.newPassword});

  Object toJson() => {
        'username': '+1' + username,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };
}
