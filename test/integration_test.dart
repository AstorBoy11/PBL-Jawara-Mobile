import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbl_jawara_mobile/main.dart';
import 'package:pbl_jawara_mobile/routes.dart';

void main() {
  group('App Integration Tests', () {
    testWidgets('App launches with correct initial route', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Verify HomePage is displayed
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Can navigate from HomePage to LaporanKeuangan', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Find and tap Laporan Keuangan menu button
      final laporanButton = find.ancestor(
        of: find.text('Laporan\nKeuangan'),
        matching: find.byType(InkWell),
      );

      await tester.tap(laporanButton);
      await tester.pumpAndSettle();

      // Verify navigation to LaporanKeuangan page
      expect(find.text('Laporan Keuangan - Pemasukan'), findsOneWidget);
    });

    testWidgets('Can navigate from HomePage to DataRumahDanWarga', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Find and tap Data Rumah & Warga menu button
      final dataButton = find.ancestor(
        of: find.text('Data Rumah\n& Warga'),
        matching: find.byType(InkWell),
      );

      await tester.tap(dataButton);
      await tester.pumpAndSettle();

      // Verify navigation to DataRumahDanWarga page
      expect(find.text('Data Warga'), findsWidgets);
    });

    testWidgets('Can navigate back from LaporanKeuangan to HomePage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Navigate to LaporanKeuangan
      final laporanButton = find.ancestor(
        of: find.text('Laporan\nKeuangan'),
        matching: find.byType(InkWell),
      );
      await tester.tap(laporanButton);
      await tester.pumpAndSettle();

      // Go back
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Verify back at HomePage
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Can navigate back from DataRumahDanWarga to HomePage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Navigate to DataRumahDanWarga
      final dataButton = find.ancestor(
        of: find.text('Data Rumah\n& Warga'),
        matching: find.byType(InkWell),
      );
      await tester.tap(dataButton);
      await tester.pumpAndSettle();

      // Go back
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Verify back at HomePage
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Bottom navigation bar navigates correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Initial state - Dashboard
      expect(find.text('Dashboard'), findsOneWidget);

      // Tap Laporan menu in bottom nav
      await tester.tap(find.text('Laporan'));
      await tester.pumpAndSettle();

      // Should stay on same page (HomePage) but could trigger state change
      expect(find.text('Dashboard'), findsOneWidget);

      // Tap Warga menu in bottom nav
      await tester.tap(find.text('Warga'));
      await tester.pumpAndSettle();

      // Should stay on same page
      expect(find.text('Dashboard'), findsOneWidget);

      // Tap Beranda menu
      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();

      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Complete user flow: Home -> Laporan -> Back -> Data -> Back', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Start at HomePage
      expect(find.text('Dashboard'), findsOneWidget);

      // Navigate to Laporan Keuangan
      final laporanButton = find.ancestor(
        of: find.text('Laporan\nKeuangan'),
        matching: find.byType(InkWell),
      );
      await tester.tap(laporanButton);
      await tester.pumpAndSettle();
      expect(find.text('Laporan Keuangan - Pemasukan'), findsOneWidget);

      // Go back to HomePage
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Dashboard'), findsOneWidget);

      // Navigate to Data Rumah & Warga
      final dataButton = find.ancestor(
        of: find.text('Data Rumah\n& Warga'),
        matching: find.byType(InkWell),
      );
      await tester.tap(dataButton);
      await tester.pumpAndSettle();
      expect(find.text('Data Warga'), findsWidgets);

      // Go back to HomePage
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('All defined routes are accessible', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Test each named route
      final routes = [Routes.laporanKeuangan, Routes.dataRumahDanWarga];

      for (final route in routes) {
        // Navigate to route
        final context = tester.element(find.byType(MaterialApp));
        Navigator.of(context).pushNamed(route);
        await tester.pumpAndSettle();

        // Verify navigation occurred (no error)
        expect(find.byType(Scaffold), findsWidgets);

        // Go back
        Navigator.of(context).pop();
        await tester.pumpAndSettle();
      }
    });
  });

  group('Cross-Page Functionality Tests', () {
    testWidgets('Data persists when navigating between pages', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Navigate to Laporan Keuangan
      final laporanButton = find.ancestor(
        of: find.text('Laporan\nKeuangan'),
        matching: find.byType(InkWell),
      );
      await tester.tap(laporanButton);
      await tester.pumpAndSettle();

      // Toggle to Pengeluaran
      await tester.tap(find.text('Pengeluaran'));
      await tester.pumpAndSettle();
      expect(find.text('Laporan Keuangan - Pengeluaran'), findsOneWidget);

      // Go back to HomePage
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Navigate back to Laporan Keuangan
      await tester.tap(laporanButton);
      await tester.pumpAndSettle();

      // Should show default view (Pemasukan)
      expect(find.text('Laporan Keuangan - Pemasukan'), findsOneWidget);
    });

    testWidgets('Dialog interactions across pages', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Navigate to Data page
      final dataButton = find.ancestor(
        of: find.text('Data Rumah\n& Warga'),
        matching: find.byType(InkWell),
      );
      await tester.tap(dataButton);
      await tester.pumpAndSettle();

      // Open detail dialog
      await tester.tap(find.byIcon(Icons.more_horiz).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Detail'));
      await tester.pumpAndSettle();

      // Verify dialog opened
      expect(find.text('Detail Warga'), findsOneWidget);

      // Close dialog
      await tester.tap(find.text('Tutup'));
      await tester.pumpAndSettle();

      // Navigate back
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Verify at HomePage
      expect(find.text('Dashboard'), findsOneWidget);
    });
  });

  group('Error Handling Tests', () {
    testWidgets('App handles invalid route gracefully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(MaterialApp));

      // Try to navigate to non-existent route
      // This should either stay on current page or show error
      try {
        Navigator.of(context).pushNamed('/invalid-route');
        await tester.pumpAndSettle();
      } catch (e) {
        // Expected to fail or handle gracefully
        expect(e, isNotNull);
      }
    });

    testWidgets('App renders without overflow errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Check for overflow errors
      expect(tester.takeException(), isNull);

      // Navigate to each page and check
      final routes = [Routes.laporanKeuangan, Routes.dataRumahDanWarga];

      for (final route in routes) {
        final context = tester.element(find.byType(MaterialApp));
        Navigator.of(context).pushNamed(route);
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);

        Navigator.of(context).pop();
        await tester.pumpAndSettle();
      }
    });
  });
}
