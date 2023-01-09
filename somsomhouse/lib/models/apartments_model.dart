import 'package:somsomhouse/models/apartment_model.dart';

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
