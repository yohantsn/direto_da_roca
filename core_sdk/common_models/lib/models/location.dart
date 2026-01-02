import 'package:common_models/models/models.dart';

class Location {
  final Coordinates coordinates;
  final String addressFormatted;
  final String countryIsoCode;
  final String state;
  final String city;

  const Location({
    required this.coordinates,
    required this.addressFormatted,
    required this.countryIsoCode,
    required this.state,
    required this.city,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    coordinates: Coordinates.fromJson(json['coordinates']),
    addressFormatted: json['address_formatted'],
    countryIsoCode: json['country_iso_code'],
    state: json['state'],
    city: json['city'],
  );

  Map<String, dynamic> toJson() => {
    'coordinates': coordinates.toJson(),
    'address_formatted': addressFormatted,
    'country_iso_code': countryIsoCode,
    'state': state,
    'city': city,
  };
}
