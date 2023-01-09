import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:somsomhouse/models/apartment_model.dart';

class GoogleMapModel {
  static LatLng currentLocation = const LatLng(37.570789, 126.916165);
  static double zoomLevel = 17;

  final List<Apartment> apartments;

  GoogleMapModel({
    required this.apartments,
  });

  factory GoogleMapModel.fromJson(Map<String, dynamic> json) => GoogleMapModel(
        apartments: (json['results'] as List<dynamic>)
            .map((e) => Apartment.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'apartments': apartments,
      };
}
