import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta_ui/horta_ui.dart';
import 'package:horta_ui/theme/horta_color.dart';
import 'package:horta_ui/theme/horta_theme.dart';
import 'package:horta_ui/widgets/horta_scaffold.dart';

void main() {
  group('Scaffold', () {
    testWidgets('Basic Scaffold Test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HortaTheme.light,
          home: Builder(
            builder: (context) => HortaScaffold(
              appBarDelegate: HortaAppBarDelegate(
                leadingImagePath:
                    'packages/horta_ui/assets/images/background.jpg',
                searchBar: HortaInputText.search(context),
                filterBar: HortaFilterBar(
                  categories: categories,
                  defaultCategory: defaultCategory,
                ),
              ),
              children: [SizedBox.shrink()],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final finderBackgroundColors = find.byWidgetPredicate((widget) {
        if (widget is Container) {
          final decoration = widget.decoration;
          if (decoration != null && decoration is BoxDecoration) {
            return decoration.color == HortaColor.light().surface;
          }
        }
        return false;
      });

      expect(finderBackgroundColors, findsOneWidget);
    });
  });
}
