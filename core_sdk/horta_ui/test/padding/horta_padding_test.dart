import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta_ui/widgets/padding/horta_padding.dart';

void main() {
  group('HortaPadding', () {
    testWidgets('renders correctly with all padding sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: HortaPadding(
            padding: HortaEdgeInsets.all(HortaPaddingSize.medium),
            child: Container(height: 100, width: 100),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });
  });
}
