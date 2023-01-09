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
