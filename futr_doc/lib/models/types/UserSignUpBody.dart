class UserSignUpBody {
  String email;
  String dropdown_value;
  String phone_number;
  bool legal;
  String password;

  UserSignUpBody(
      {required this.email,
      required this.dropdown_value,
      required this.phone_number,
      required this.legal,
      required this.password});

  Object toJson() => {
        'email': email + dropdown_value,
        'phone_number': '+1' + phone_number,
        'legal': legal.toString(),
        'password': password
      };
}
