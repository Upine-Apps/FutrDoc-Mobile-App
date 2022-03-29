import 'package:flutter/material.dart';
import '../models/User.dart';

final User initialData = User(
    id: 1,
    first_name: 'Tate',
    last_name: 'Walker',
    email: 'admin@upineapps.com',
    phone_number: '+12816308212',
    institution: 'TAMU',
    student_id: '824003029',
    legal: true);

class UserProvider with ChangeNotifier {
  // All users (that will be displayed on the Home screen)
  User _user = initialData;

  // Retrieve all users
  User get users => _user;

  setUser(User user) {
    _user = user;
  }

  clearUser() {
    _user = initialData;
  }
}
