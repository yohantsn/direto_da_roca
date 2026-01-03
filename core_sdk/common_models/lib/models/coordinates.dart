class Coordinates {
  final double lat;
  final double lng;

  const Coordinates({required this.lat, required this.lng});

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(lat: json['lat'], lng: json['lng']);
}
