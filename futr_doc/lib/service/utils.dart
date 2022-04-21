import '../models/Shadowing.dart';

durationToString(int duration) {
  var d = Duration(minutes: duration);
  List<String> parts = d.toString().split(':');
  return '${parts[0]}:${parts[1].padLeft(2, '0')}';
}

icd10sToString(icd10s) {
  String concatenatedString = '';
  for (var i in icd10s) {
    concatenatedString += '${i['icd']}, ';
  }
  return (concatenatedString.substring(0, concatenatedString.length - 2));
}
