// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expandable_content_list_example/main.dart';

void main() {
  testWidgets('ExpandableContentSection displays section titles and items',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Check for section titles
    expect(find.text('Section 1'), findsOneWidget);
    expect(find.text('Section 2'), findsOneWidget);

    // Check for initial visible items (limit: 2)
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);

    // "See More" button should be visible
    expect(find.text('See More'), findsOneWidget);

    // Tap "See More" to expand
    await tester.tap(find.text('See More'));
    await tester.pumpAndSettle();

    // Now all items should be visible
    expect(find.text('Item 3'), findsOneWidget);
    expect(find.text('Item 4'), findsOneWidget);

    // "Show Less" button should be visible
    expect(find.text('Show Less'), findsOneWidget);
  });
}
