import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/models/map_model.dart';

class DBServices {
  Future<GoogleMapModel> getApartments(
      double lat, double lng, double zoomLevel) async {
    String googleLocationsURL =
        'http://localhost:8080/get_location?lat=$lat&lng=$lng&zoomlevel=$zoomLevel';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    return GoogleMapModel.fromJson(dataConvertedJSON);
  }

  Future<ChartModel> selectEndIndex(String apartName) async {
    String url = 'http://localhost:8080/get_end_index?name=$apartName';

    final response = await http.get(Uri.parse(url));
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));

    return Future.value(ChartModel());
  }
}
