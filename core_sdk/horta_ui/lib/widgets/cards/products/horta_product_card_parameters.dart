import 'package:flutter/material.dart';

enum ProductStatus { seasonal, inStock, lowStock, outOfStock }

extension ProductStatusExtension on ProductStatus {
  String get name {
    switch (this) {
      case ProductStatus.seasonal:
        return "Sazonal";
      case ProductStatus.inStock:
        return "Em Estoque";
      case ProductStatus.lowStock:
        return "Estoque Baixo";
      case ProductStatus.outOfStock:
        return "Esgotado";
    }
  }

  Color get color {
    switch (this) {
      case ProductStatus.seasonal:
        return Colors.orange;
      case ProductStatus.inStock:
        return Colors.green;
      case ProductStatus.lowStock:
        return Colors.amber;
      case ProductStatus.outOfStock:
        return Colors.red;
    }
  }
}

class HortaProductCardParameters {
  final String imageUrl;
  final String onFailureImage;
  final String title;
  final String price;
  final String unit;
  final String currency;
  final ProductStatus status;
  final VoidCallback? onOrderPressed;

  const HortaProductCardParameters({
    required this.imageUrl,
    required this.onFailureImage,
    required this.title,
    required this.price,
    required this.unit,
    required this.status,
    required this.currency,
    required this.onOrderPressed,
  });
}
