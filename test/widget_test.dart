// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:finora/app.dart';

void main() {
  testWidgets('Finora can add a local expense', (WidgetTester tester) async {
    await tester.pumpWidget(const FinoraApp());
    await tester.pumpAndSettle();

    expect(find.text('Good evening'), findsOneWidget);
    expect(find.text('NET WORTH'), findsOneWidget);

    await tester.tap(find.byTooltip('Quick add'));
    await tester.pumpAndSettle();

    expect(find.text('Add transaction'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'Description'), 'Coffee');
    await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '180');
    await tester.tap(find.text('Save transaction'));
    await tester.pumpAndSettle();

    expect(find.text('Coffee'), findsOneWidget);
  });
}
