import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta_ui/horta_ui.dart';

void main() {
  final listCards = [
    HortaProductCardParameters(
      imageUrl: "https://www.freeiconspng.com/uploads/no-image-icon-1.jpg",
      onFailureImage: "assets/images/background.jpg",
      title: "Banana",
      price: "1.99",
      unit: "kg",
      status: ProductStatus.inStock,
      currency: "R\$",
      onOrderPressed: () {},
    ),
  ];

  group('HortaProductGrid', () {
    testWidgets('Render properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SingleChildScrollView(
            child: HortaProductGrid(
              itemCount: listCards.length,
              itemBuilder: (context, index) {
                return HortaProductCard(parameters: listCards[index]);
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final finderTextButton = find.text("Pedir agora");
      expect(finderTextButton, findsOne);

      final finderStatus = find.text("Em Estoque");
      expect(finderStatus, findsOne);

      final finderProductTitle = find.text("Banana");
      expect(finderProductTitle, findsOne);
    });

    testWidgets('Render OutOfStock properly', (tester) async {
      listCards.removeAt(0);
      listCards.addAll([
        HortaProductCardParameters(
          imageUrl: "https://www.freeiconspng.com/uploads/no-image-icon-1.jpg",
          onFailureImage: "assets/images/background.jpg",
          title: "Banana",
          price: "1.99",
          unit: "kg",
          status: ProductStatus.outOfStock,
          currency: "R\$",
          onOrderPressed: () {},
        ),
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: SingleChildScrollView(
            child: HortaProductGrid(
              itemCount: listCards.length,
              itemBuilder: (context, index) {
                return HortaProductCard(parameters: listCards[index]);
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final finderStatus = find.text("Esgotado");
      expect(finderStatus, findsOne);

      final finderStatusColor = find.byWidgetPredicate((widget) {
        if (widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color == Colors.red) {
          return true;
        }
        return false;
      });
      expect(finderStatusColor, findsOne);
    });

    testWidgets('Render lowStock properly', (tester) async {
      listCards.removeAt(0);
      listCards.addAll([
        HortaProductCardParameters(
          imageUrl: "https://www.freeiconspng.com/uploads/no-image-icon-1.jpg",
          onFailureImage: "assets/images/background.jpg",
          title: "Banana",
          price: "1.99",
          unit: "kg",
          status: ProductStatus.lowStock,
          currency: "R\$",
          onOrderPressed: () {},
        ),
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: SingleChildScrollView(
            child: HortaProductGrid(
              itemCount: listCards.length,
              itemBuilder: (context, index) {
                return HortaProductCard(parameters: listCards[index]);
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final finderStatus = find.text("Estoque Baixo");
      expect(finderStatus, findsOne);

      final finderStatusColor = find.byWidgetPredicate((widget) {
        if (widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color == Colors.amber) {
          return true;
        }
        return false;
      });
      expect(finderStatusColor, findsOne);
    });

    testWidgets('Render seasonal properly', (tester) async {
      listCards.removeAt(0);
      listCards.addAll([
        HortaProductCardParameters(
          imageUrl: "https://www.freeiconspng.com/uploads/no-image-icon-1.jpg",
          onFailureImage: "assets/images/background.jpg",
          title: "Banana",
          price: "1.99",
          unit: "kg",
          status: ProductStatus.seasonal,
          currency: "R\$",
          onOrderPressed: () {},
        ),
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: SingleChildScrollView(
            child: HortaProductGrid(
              itemCount: listCards.length,
              itemBuilder: (context, index) {
                return HortaProductCard(parameters: listCards[index]);
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final finderStatus = find.text("Sazonal");
      expect(finderStatus, findsOne);

      final finderStatusColor = find.byWidgetPredicate((widget) {
        if (widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color == Colors.orange) {
          return true;
        }
        return false;
      });
      expect(finderStatusColor, findsOne);
    });
  });
}
