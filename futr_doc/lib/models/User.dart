class User {
  String id;
  String? first_name;
  String? last_name;
  String email;
  String phone_number;
  String? institution;
  String? student_id;
  String? degree;
  String? school_year;
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
      this.school_year,
      required this.legal});

  static User jsonToUser(data) {
    print(data);
    print(data['email']);
    return User(
        id: data['id'].toString(),
        first_name: data['first_name'],
        last_name: data['last_name'],
        email: data['email'],
        phone_number: data['phone_number'].substring(2),
        institution: data['institution'],
        student_id: data['student_id'],
        degree: data['degree'],
        school_year: data['school_year'],
        legal: data['legal']);
  }

  static User emptyUserObject() => new User(
      id: '',
      first_name: '',
      last_name: '',
      email: '',
      phone_number: '',
      institution: '',
      student_id: '',
      degree: '',
      school_year: '',
      legal: true);
}
