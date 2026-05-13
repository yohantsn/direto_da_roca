import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta_ui/horta_ui.dart';

void main() {
  group('HortaTextField', () {
    testWidgets('name() creates field with correct keyboard type and icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HortaTheme.light,
          home: Scaffold(
            body: HortaTextField.name(),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField).first,
      );
      expect(textField.keyboardType, TextInputType.name);
      expect(tester.widget<Icon>(find.byIcon(Icons.person)), isNotNull);
    });

    testWidgets('email() creates field with correct keyboard type and icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HortaTheme.light,
          home: Scaffold(
            body: HortaTextField.email(),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField).first,
      );
      expect(textField.keyboardType, TextInputType.emailAddress);
      expect(tester.widget<Icon>(find.byIcon(Icons.email)), isNotNull);
    });

    testWidgets('phone() creates field with correct keyboard type and icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HortaTheme.light,
          home: Scaffold(
            body: HortaTextField.phone(),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField).first,
      );
      expect(textField.keyboardType, TextInputType.phone);
      expect(tester.widget<Icon>(find.byIcon(Icons.phone)), isNotNull);
    });

    testWidgets('cep() creates field with correct keyboard type and icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HortaTheme.light,
          home: Scaffold(
            body: HortaTextField.cep(),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField).first,
      );
      expect(textField.keyboardType, TextInputType.number);
      expect(tester.widget<Icon>(find.byIcon(Icons.pin_drop)), isNotNull);
    });

    testWidgets('password() creates field with correct keyboard type and icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HortaTheme.light,
          home: Scaffold(
            body: HortaTextField.password(),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField).first,
      );
      expect(textField.keyboardType, TextInputType.visiblePassword);
      expect(textField.obscureText, true);
      expect(tester.widget<Icon>(find.byIcon(Icons.lock)), isNotNull);
    });
  });
}
