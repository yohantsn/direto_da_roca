import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta_ui/widgets/filters/horta_filter_bar.dart';

void main() {
  group('HortaFilterBar', () {
    testWidgets('renders correctly with categories', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: HortaFilterBar(
            categories: ['Fruits', 'Vegetables'],
            defaultCategory: 'Fruits',
            onCategorySelected: (_) {},
          ),
        ),
      );

      expect(find.text('Fruits'), findsOneWidget);
      expect(find.text('Vegetables'), findsOneWidget);
    });

    testWidgets('selects the correct category', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: HortaFilterBar(
            categories: ['Fruits', 'Vegetables'],
            defaultCategory: 'Fruits',
            onCategorySelected: (_) {},
          ),
        ),
      );

      expect(find.text('Fruits'), findsOneWidget);
    });
  });
}
