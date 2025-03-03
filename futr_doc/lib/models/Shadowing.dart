import 'dart:convert';
import 'ICD.dart';

class Shadowing {
  String? id;
  String? clinic_name;
  String? physician_email;
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
      this.physician_email,
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
        physician_email: data['physician_email'],
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
        'physician_email': physician_email!,
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

  String getIndexForPdf(int index) {
    switch (index) {
      case 0:
        return this.date!;
      case 1:
        return this.duration!;
      case 2:
        return this.clinic_name!;
      case 3:
        var icd10Name = '';
        this.icd10![0]['name'].length > 20
            ? icd10Name = '${this.icd10![0]['name'].substring(0, 20)} ...'
            : icd10Name = this.icd10![0]['name'];
        return icd10Name;
    }
    return '';
  }

  static Shadowing emptyShadowingObject() => new Shadowing(
        id: '',
        clinic_name: '',
        physician_email: '',
        date: '',
        duration: '',
        activity: '',
        patient_type: '',
        icd10: [],
        validated: false,
        user_id: '',
      );
}
