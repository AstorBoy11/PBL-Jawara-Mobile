import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbl_jawara_mobile/Pages/home_page.dart';

void main() {
  group('HomePage Widget Tests', () {
    testWidgets('HomePage displays title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.text('Jawara Pintar'), findsOneWidget);
    });

    testWidgets('HomePage displays AppBar with title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.text('Home'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('HomePage displays all navigation buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.text('Data Rumah dan Warga'), findsOneWidget);
      expect(find.text('Laporan Keuangan'), findsOneWidget);
      expect(find.text('Channel Transfer'), findsOneWidget);
    });

    testWidgets('HomePage has correct button icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.byIcon(Icons.home_work), findsOneWidget);
      expect(find.byIcon(Icons.receipt_long), findsOneWidget);
      expect(find.byIcon(Icons.transfer_within_a_station), findsOneWidget);
    });

    testWidgets('HomePage has three navigation buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      // Check that all three button texts exist
      expect(find.text('Data Rumah dan Warga'), findsOneWidget);
      expect(find.text('Laporan Keuangan'), findsOneWidget);
      expect(find.text('Channel Transfer'), findsOneWidget);
    });

    testWidgets('HomePage content is centered', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.byType(Center), findsWidgets);
      expect(find.byType(Column), findsOneWidget);
    });
  });

  group('HomePage Style Tests', () {
    testWidgets('AppBar has blue background', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, Colors.blue);
    });

    testWidgets('Title has correct text style', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final textWidget = tester.widget<Text>(find.text('Jawara Pintar'));
      expect(textWidget.style?.fontSize, 28);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });
  });
}
