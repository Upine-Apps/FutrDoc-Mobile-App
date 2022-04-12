import 'dart:convert';

class Shadowing {
  String? id;
  String? clinic_name;
  String? date;
  String? duration;
  String? activity;
  String? patient_type;
  List<String>? icd10;
  bool? validated;
  String? user_id;

  Shadowing(
      {this.id,
      this.clinic_name,
      this.date,
      this.duration,
      this.activity,
      this.patient_type,
      this.icd10,
      this.validated,
      this.user_id});

  static Shadowing jsonToShadowing(data) {
    print(data);
    return Shadowing(
        id: data['id'].toString(),
        clinic_name: data['clinic_name'],
        date: data['date'],
        duration: data['duration'],
        activity: data['activity'],
        patient_type: data['patient_type'],
        icd10: data['icd10'],
        validated: data['validated'],
        user_id: data['user_id']);
  }

  Map<String, String> toJson() => {
        'id': id!,
        'clinic_name': clinic_name!,
        'date': date!,
        'duration': duration!,
        'activity': activity!,
        'patient_type': patient_type!,
        'icd10': jsonEncode(icd10!),
        'validated': validated!.toString(),
        'user_id': user_id!
      };

  static Shadowing emptyShadowingObject = new Shadowing(
    id: '',
    clinic_name: '',
    date: '',
    duration: '',
    activity: '',
    patient_type: '',
    icd10: [],
    validated: false,
    user_id: '',
  );
}
