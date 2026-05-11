import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta_ui/widgets/cards/products/horta_product_card.dart';

void main() {
  group('HortaProductCard', () {
    testWidgets('renders correctly with all parameters', (WidgetTester tester) async {
      final parameters = HortaProductCardParameters(
        imageUrl: "https://www.freeiconspng.com/uploads/no-image-icon-1.jpg",
        onFailureImage: "assets/images/background.jpg",
        title: "Banana",
        price: "1.99",
        unit: "kg",
        status: ProductStatus.inStock,
        currency: "R\$",
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: HortaProductCard(parameters: parameters),
        ),
      );

      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('R\$ 1.99 / kg'), findsOneWidget);
    });
  });
}
