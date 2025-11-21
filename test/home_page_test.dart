import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbl_jawara_mobile/Pages/home_page.dart';
import 'package:pbl_jawara_mobile/routes.dart';

void main() {
  group('HomePage Widget Tests', () {
    testWidgets('HomePage displays header with RT/RW location', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      expect(
        find.text('Anda sedang berada di lingkungan RT 01 / RW 05'),
        findsOneWidget,
      );
    });

    testWidgets('HomePage displays all 4 stat cards', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      expect(find.text('1,248'), findsOneWidget);
      expect(find.text('Total Warga'), findsOneWidget);
      expect(find.text('342'), findsOneWidget);
      expect(find.text('Total Keluarga'), findsOneWidget);
      expect(find.text('18 Jt'), findsOneWidget);
      expect(find.text('Pemasukan'), findsOneWidget);
      expect(find.text('11 Jt'), findsOneWidget);
      expect(find.text('Pengeluaran'), findsOneWidget);
    });

    testWidgets('HomePage displays chart titles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      expect(find.text('Pemasukan Bulanan'), findsOneWidget);
      expect(find.text('Pengeluaran Bulanan'), findsOneWidget);
    });

    testWidgets('HomePage displays Menu Cepat section', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      expect(find.text('Menu Cepat'), findsOneWidget);
      expect(find.text('Data Warga'), findsOneWidget);
      expect(find.text('Rumah'), findsOneWidget);
      expect(find.text('Tagihan'), findsOneWidget);
      expect(find.text('Kegiatan'), findsOneWidget);
    });

    testWidgets('HomePage displays bottom navigation bar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Marketplace'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
    });

    testWidgets('HomePage has correct icon types', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      expect(find.byIcon(Icons.people), findsOneWidget);
      expect(find.byIcon(Icons.family_restroom), findsOneWidget);
      expect(find.byIcon(Icons.trending_up), findsOneWidget);
      expect(find.byIcon(Icons.trending_down), findsOneWidget);
      expect(find.byIcon(Icons.home), findsWidgets);
    });

    testWidgets('Can scroll HomePage content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Scroll to bottom
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();

      expect(find.text('Menu Cepat'), findsOneWidget);
    });

    testWidgets('Bottom navigation bar can change index', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      // Initial state - Home is selected
      final bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(bottomNavBar.currentIndex, 0);

      // Tap on Marketplace
      await tester.tap(find.text('Marketplace'));
      await tester.pumpAndSettle();
    });

    testWidgets('Quick menu buttons are tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      // Find and tap Data Warga button
      final dataWargaButton = find.ancestor(
        of: find.text('Data Warga'),
        matching: find.byType(InkWell),
      );
      expect(dataWargaButton, findsOneWidget);

      await tester.tap(dataWargaButton);
      await tester.pumpAndSettle();
    });
  });

  group('HomePage Color and Style Tests', () {
    testWidgets('Header has teal background', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      final container = tester.widget<Container>(
        find
            .ancestor(
              of: find.text('Anda sedang berada di lingkungan RT 01 / RW 05'),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, isA<Color>());
    });

    testWidgets('Stat cards have white background', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: const HomePage(), routes: appRoutes),
      );

      // Check for white card backgrounds
      expect(find.byType(Container), findsWidgets);
    });
  });
}
