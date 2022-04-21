import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/PlaceSearch.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlacesService {
  final key = dotenv.env['GOOGLE_MAPS_KEY'];
  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    print(search);
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=establishment&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['predictions'] as List;

    return jsonResult.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
