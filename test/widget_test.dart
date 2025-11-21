// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pbl_jawara_mobile/main.dart';

void main() {
  testWidgets('JawaraApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const JawaraApp());
    await tester.pumpAndSettle();

    // Verify that the app launches correctly with HomePage
    expect(find.text('Jawara Pintar'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    // Verify that navigation buttons are present
    expect(find.text('Data Rumah dan Warga'), findsOneWidget);
    expect(find.text('Laporan Keuangan'), findsOneWidget);
    expect(find.text('Channel Transfer'), findsOneWidget);
  });

  testWidgets('JawaraApp has MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(const JawaraApp());

    // Verify MaterialApp exists
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('JawaraApp displays correct title', (WidgetTester tester) async {
    await tester.pumpWidget(const JawaraApp());
    await tester.pumpAndSettle();

    // Verify the main title is displayed
    expect(find.text('Jawara Pintar'), findsOneWidget);
  });
}
