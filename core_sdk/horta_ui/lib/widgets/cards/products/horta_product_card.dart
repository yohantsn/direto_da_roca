import 'package:flutter/material.dart';
import 'package:horta_ui/widgets/cards/products/horta_product_card_parameters.dart';

class HortaProductCard extends StatelessWidget {
  final HortaProductCardParameters parameters;
  static const _kImageHeight = 250.0;
  static const _kborderRadiusValue = 16.0;
  static const _kPaddingValue = 16.0;

  const HortaProductCard({super.key, required this.parameters});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(_kborderRadiusValue),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .spaceBetween,
        children: [
          Stack(
            children: [
              Padding(
                padding: .all(_kPaddingValue),
                child: ClipRRect(
                  borderRadius: .all(.circular(_kborderRadiusValue)),
                  child: Image.network(
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        parameters.onFailureImage,
                        height: _kImageHeight,
                        width: .infinity,
                        fit: .cover,
                      );
                    },
                    parameters.imageUrl,
                    height: _kImageHeight,
                    width: .infinity,
                    fit: .cover,
                  ),
                ),
              ),
              Positioned(
                top: 24,
                right: 24,
                child: Container(
                  padding: .symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: parameters.status.color,
                    borderRadius: .circular(20),
                  ),
                  child: Text(
                    parameters.status.name,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const .all(_kPaddingValue),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              mainAxisSize: .max,
              children: [
                Text(
                  parameters.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontWeight: .bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "${parameters.currency} ${parameters.price} / ${parameters.unit}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: .w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: parameters.onOrderPressed,
                        icon: Icon(Icons.chat),
                        label: Text("Pedir agora"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
