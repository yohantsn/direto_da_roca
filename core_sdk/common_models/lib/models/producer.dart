import 'package:common_models/models/models.dart';

class Producer {
  final int? id;
  final String name;
  final String description;
  final Location location;
  final String phone;
  final String email;
  final bool isVerified;
  final List<Product>? products; // Relacionamento

  const Producer({
    this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.phone,
    required this.email,
    required this.isVerified,
    this.products,
  });

  factory Producer.fromJson(Map<String, dynamic> json) {
    return Producer(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      phone: json['phone'],
      email: json['email'],
      isVerified: json['is_verified'] ?? false,
      location: Location.fromJson(json['location_data'] ?? {}),
      // Mapeia a lista de produtos se ela vier no JOIN do Supabase
      products: json['products'] != null
          ? (json['products'] as List).map((p) => Product.fromJson(p)).toList()
          : null,
    );
  }
  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'phone': phone,
    'email': email,
    'isVerified': isVerified,
    'location': location.toJson(),
  };
}
