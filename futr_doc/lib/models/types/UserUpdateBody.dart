class UserUpdateBody {
  String id;
  String? first_name;
  String? last_name;
  String? email;
  String? phone_number;
  String? institution;
  String? student_id;
  String? school_year;
  String? degree;
  bool? legal;

  UserUpdateBody(
      {required this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.phone_number,
      this.institution,
      this.student_id,
      this.degree,
      this.school_year,
      this.legal});

  Object toJson() => {
        'id': id,
        'first_name': first_name ?? null,
        'last_name': last_name ?? null,
        'email': email ?? null,
        'phone_number': phone_number != null ? '+1' + phone_number! : null,
        'institution': institution ?? null,
        'degree': degree ?? null,
        'school_year': school_year ?? null,
        'legal': 'true',
      };
}
