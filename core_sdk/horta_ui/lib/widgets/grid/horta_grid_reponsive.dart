import 'package:flutter/material.dart';
import 'package:horta_ui/widgets/cards/products/horta_product_card.dart';
import 'package:horta_ui/widgets/padding/horta_padding.dart';

class HortaProductGrid extends StatelessWidget {
  final int itemCount;
  final HortaProductCard Function(BuildContext, int) itemBuilder;
  static const _kMainAxisExtent = 430.0;
  static const _kAxisSpacing = 16.0;

  const HortaProductGrid({super.key, required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / 280).floor();

        return HortaPadding(
          padding: .all(.large),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: _kAxisSpacing,
              crossAxisSpacing: _kAxisSpacing,
              mainAxisExtent: _kMainAxisExtent,
            ),
            itemBuilder: itemBuilder,
            itemCount: itemCount,
          ),
        );
      },
    );
  }
}
