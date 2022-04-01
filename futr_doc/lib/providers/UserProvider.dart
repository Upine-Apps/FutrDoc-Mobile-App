import 'package:flutter/material.dart';
import '../models/User.dart';

final User initialData = User(
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

class UserProvider with ChangeNotifier {
  User _user = initialData;

  // Retrieve user
  User get user => _user;

  setUser(User user) {
    _user = user;
  }

  clearUser() {
    _user = initialData;
  }
}
