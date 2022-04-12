import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/PlaceSearch.dart';


class PlacesService {
  final key = 'AIzaSyBQgN0iD8Wo5zNt_FSu_YLreNK9zfwjeKQ';
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
