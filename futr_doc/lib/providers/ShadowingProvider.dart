import 'package:flutter/material.dart';
import '../models/Shadowing.dart';

final List<Shadowing> initialData = [
  //probably need to remove this when displaying the stuff? Not sure
  Shadowing(
    id: '',
    clinic_name: '',
    date: '',
    duration: '',
    activity: '',
    patient_type: '',
    icd10: [],
    validated: false,
    user_id: '',
  ),
];

class ShadowingProvider with ChangeNotifier {
  // All shadowings (that will be displayed on the Home screen)
  final List<Shadowing> _shadowings = initialData;

  // Retrieve all shadowings
  List<Shadowing> get shadowings => _shadowings;

  Shadowing get lastShadowing => _shadowings.last;

  setLastShadowing(Shadowing updatedShadowing) {
    _shadowings.last = updatedShadowing;
    notifyListeners();
  }

  // Adding a Shadowing to the favorites list
  void addToShadowings(Shadowing shadowing) {
    _shadowings.add(shadowing);
    notifyListeners();
  }

  // Removing a Shadowing from the list
  void removeFromList(Shadowing shadowing) {
    _shadowings.remove(shadowing);
    notifyListeners();
  }

  void clearList() {
    _shadowings.clear();
    notifyListeners();
  }
}
