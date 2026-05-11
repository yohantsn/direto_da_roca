import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta_ui/widgets/input_text/horta_input_text.dart';

void main() {
  group('HortaInputText', () {
    testWidgets('renders correctly with search input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: HortaInputText.search(
            context,
            hintText: 'Search...',
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
