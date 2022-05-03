import 'dart:convert';
import 'ICD.dart';

class Shadowing {
  String? id;
  String? clinic_name;
  String? phone_number;
  String? date;
  String? duration;
  String? activity;
  String? patient_type;
  List<dynamic>? icd10;
  bool? validated;
  String? user_id;

  Shadowing(
      {this.id,
      this.clinic_name,
      this.phone_number,
      this.date,
      this.duration,
      this.activity,
      this.patient_type,
      this.icd10,
      this.validated,
      this.user_id});

  static Shadowing jsonToShadowing(data) {
    print(data);
    for (var prop in data.keys) {
      // print(prop);
      // print(data[prop].runtimeType);
      if (prop == 'icd10' && data[prop] != null) {
        print(data[prop].runtimeType);
        print(data[prop]);
        // print(jsonDecode(data[prop]));
        // print(jsonDecode(data[prop]).runtimeType);
      }
    }
    return Shadowing(
        id: data['id'].toString(),
        clinic_name: data['clinic_name'],
        phone_number: data['phone_number'],
        date: data['date'],
        duration: data['duration'].toString(),
        activity: data['activity'],
        patient_type: data['patient_type'],
        icd10: data['icd10'] ?? [],
        validated: data['validated'],
        user_id: data['user_id'].toString());
  }

  Map<String, String> toJson() => {
        'id': id!,
        'clinic_name': clinic_name!,
        'phone_number': phone_number!,
        'date': date!,
        'duration': duration!,
        'activity': activity!,
        'patient_type': patient_type!,
        'icd10': jsonEncode(icd10!),
        'validated': validated!.toString(),
        'user_id': user_id!
      };

// 'icd10': '/[{name: owefi}/]'
// 'icd10': [{name: asdfasd}, {name: oaiwjefoa}]
//
//

  static Shadowing emptyShadowingObject() => new Shadowing(
        id: '',
        clinic_name: '',
        phone_number: '',
        date: '',
        duration: '',
        activity: '',
        patient_type: '',
        icd10: [],
        validated: false,
        user_id: '',
      );
}
