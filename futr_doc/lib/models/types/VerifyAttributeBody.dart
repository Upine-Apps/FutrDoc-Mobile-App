class VerifyAttributeBody {
  String username;
  String code;

  VerifyAttributeBody({
    required this.username,
    required this.code,
  });

  Object toJson() => {
        'username': '+1' + username,
        'code': code,
      };
}
