class ChangeAttributeBody {
  String username;
  String attributeName;
  String attributeValue;

  ChangeAttributeBody(
      {required this.username,
      required this.attributeName,
      required this.attributeValue});

  Object toJson() => {
        'username': '+1' + username,
        'attributeName': attributeName,
        'attributeValue': attributeValue,
      };
}
