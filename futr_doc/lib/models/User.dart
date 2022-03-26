class User {
  final int id;
  final String? first_name;
  final String? last_name;
  final String email;
  final String phone_number;
  final String? institution;
  final String? student_id;
  final bool legal;

  User(
      {required this.id,
      this.first_name,
      this.last_name,
      required this.email,
      required this.phone_number,
      this.institution,
      this.student_id,
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
