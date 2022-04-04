class UnauthenticatedUserBody {
  String username;

  UnauthenticatedUserBody({
    required this.username,
  });

  Object toJson() => {
        'username': '+1' + username,
      };
}
