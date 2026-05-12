import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_sdk/horta_ui/widgets/text_field/horta_text_field.dart';
import 'package:core_sdk/horta_ui/widgets/text_field/horta_text_field_factory.dart';

void main() {
  testWidgets('HortaTextField renders with correct label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: HortaTextField(
            label: 'Test Label',
          ),
        ),
      ),
    );

    expect(find.text('Test Label'), findsOneWidget);
  });

  testWidgets('HortaTextField.email uses correct keyboardType', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: HortaTextField.email(),
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.keyboardType, TextInputType.emailAddress);
  });

  testWidgets('HortaTextField.password isObscure is true', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: HortaTextField.password(),
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.obscureText, isTrue);
  });

  testWidgets('HortaTextField.name uses person icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: HortaTextField.name(),
        ),
      ),
    );

    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('HortaTextField.cep uses number keyboardType', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: HortaTextField.cep(),
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.keyboardType, TextInputType.number);
  });

  testWidgets('HortaTextField.password shows visibility toggle', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: HortaTextField.password(),
        ),
      ),
    );

    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });

  testWidgets('HortaTextField shows error message when errorMsg is provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          body: HortaTextField(
            label: 'Test',
            errorMsg: 'Erro de validação',
          ),
        ),
      ),
    );

    expect(find.text('Erro de validação'), findsOneWidget);
  });
}
