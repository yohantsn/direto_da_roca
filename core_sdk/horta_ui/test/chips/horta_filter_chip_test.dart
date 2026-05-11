import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta_ui/widgets/chips/horta_filter_chip.dart';

void main() {
  group('HortaFilterChip', () {
    testWidgets('renders correctly when selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: HortaFilterChip(
            category: 'Fruits',
            isSelected: true,
            onSelected: (_) {},
          ),
        ),
      );

      expect(find.text('Fruits'), findsOneWidget);
    });

    testWidgets('renders correctly when not selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: HortaFilterChip(
            category: 'Vegetables',
            isSelected: false,
            onSelected: (_) {},
          ),
        ),
      );

      expect(find.text('Vegetables'), findsOneWidget);
    });
  });
}
