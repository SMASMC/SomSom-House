import 'dart:convert';

import 'package:http/http.dart' as http;

class Apartment {
  final String name;
  final double lat;
  final double lng;

  Apartment({
    required this.name,
    required this.lat,
    required this.lng,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) => Apartment(
        name: (json['name'] as String),
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'lat': lat,
        'lng': lng,
      };
}

class Locations {
  final List<Apartment> apartments;

  Locations({
    required this.apartments,
  });

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        apartments: (json['results'] as List<dynamic>)
            .map((e) => Apartment.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'apartments': apartments,
      };
}

Future<Locations> getApartments(
    double lat, double lng, double zoomLevel) async {
  String googleLocationsURL =
      'http://localhost:8080/get_location?lat=${lat}&lng=${lng}&zoomlevel=${zoomLevel}';

  final response = await http.get(Uri.parse(googleLocationsURL));
  var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));

  return Locations.fromJson(dataConvertedJSON);
}
