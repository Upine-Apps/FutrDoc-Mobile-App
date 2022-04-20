import '../models/Shadowing.dart';

durationToString(int duration) {
  var d = Duration(minutes: duration);
  List<String> parts = d.toString().split(':');
  return '${parts[0]}:${parts[1].padLeft(2, '0')}';
}
