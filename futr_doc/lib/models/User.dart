class User {
  String id;
  String? first_name;
  String? last_name;
  String email;
  String phone_number;
  String? institution;
  String? student_id;
  String? degree;
  String? schoolYear;
  bool legal;

  User(
      {required this.id,
      this.first_name,
      this.last_name,
      required this.email,
      required this.phone_number,
      this.institution,
      this.student_id,
      this.degree,
      this.schoolYear,
      required this.legal});

  static User jsonToUser(data) {
    print(data);
    print(data['email']);
    return User(
        id: data['id'],
        email: data['email'],
        phone_number: data['phone_number'],
        legal: data['legal']);
  }
}
