import 'package:flutter/material.dart';
import '../models/User.dart';

final List<User> initialData = [
  User(
      id: 1,
      first_name: 'Tate',
      last_name: 'Walker',
      email: 'admin@upineapps.com',
      phone_number: '+12816308212',
      institution: 'TAMU',
      student_id: '824003029',
      legal: true)
];

class UserProvider with ChangeNotifier {
  // All users (that will be displayed on the Home screen)
  final List<User> _users = initialData;

  // Retrieve all users
  List<User> get users => _users;

  // Favorite users (that will be shown on the MyList screen)
  final List<User> _myList = [];

  // Retrieve favorite users
  List<User> get myList => _myList;

  // Adding a User to the favorites list
  void addToList(User user) {
    _myList.add(user);
    notifyListeners();
  }

  // Removing a User from the favorites list
  void removeFromList(User user) {
    _myList.remove(user);
    notifyListeners();
  }

  void clearList() {
    _myList.clear();
    notifyListeners();
  }
}
