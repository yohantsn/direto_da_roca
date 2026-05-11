import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horta_ui/widgets/app_bar/horta_app_bar.dart';

void main() {
  group('HortaAppBarDelegate', () {
    testWidgets('renders correctly with leading image path', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: HortaAppBarDelegate(leadingImagePath: 'assets/images/logo.png'),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders correctly with web menu items', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: HortaAppBarDelegate(
                  leadingImagePath: 'assets/images/logo.png',
                  webMenuItems: HortaListMenuSectionWeb(
                    menuItems: ['Home', 'About'],
                    onItemPressed: (item) {},
                    selectedItem: 'Home',
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });
  });
}
