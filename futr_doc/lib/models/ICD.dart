class ICD {
  String? name;
  String? icd;

  ICD({this.name, this.icd});

  static ICD jsonToIcd(data) {
    print(data);
    return ICD(name: data['name'], icd: data['icd']);
  }

  ICD.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        icd = json['icd'];

  Map<String, String> toJson(data) => {
        'name': data.name!,
        'icd': data.icd!,
      };
}
