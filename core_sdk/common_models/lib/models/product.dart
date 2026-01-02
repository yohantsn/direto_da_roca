enum Availability { available, outOfStock, seasonal }

enum UnityType { kg, unit, liter, gram }

enum ProductType {
  vegetables,
  eggs,
  cheese,
  milk,
  leguminous,
  honey,
  jam,
  others,
}

class Product {
  final int? id;
  final int producerId; // Chave estrangeira
  final String name;
  final String imageUrl;
  final Availability availability;
  final double price;
  final UnityType unity;
  final ProductType type;

  const Product({
    this.id,
    required this.producerId,
    required this.name,
    required this.imageUrl,
    required this.availability,
    required this.price,
    required this.unity,
    required this.type,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    producerId: json['producer_id'],
    name: json['name'],
    imageUrl: json['image_url'],
    availability: Availability.values.byName(json['availability']),
    price: (json['price'] as num).toDouble(),
    unity: UnityType.values.byName(json['unity']),
    type: ProductType.values.byName(json['type']),
  );

  Map<String, dynamic> toJson() => {
    'producer_id': producerId,
    'name': name,
    'image_url': imageUrl,
    'availability': availability.name,
    'price': price,
    'unity': unity.name,
    'type': type.name,
  };
}
