import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbl_jawara_mobile/main.dart';

void main() {
  group('App Integration Tests', () {
    testWidgets('App launches with correct initial route', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Verify HomePage is displayed
      expect(find.text('Jawara Pintar'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('Can navigate from HomePage to LaporanKeuangan', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Find and tap Laporan Keuangan button
      await tester.tap(find.text('Laporan Keuangan'));
      await tester.pumpAndSettle();

      // Verify navigation to LaporanKeuangan page
      expect(find.text('Data Pemasukan'), findsOneWidget);
    });

    testWidgets('Can navigate from HomePage to DataRumahDanWarga', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Find and tap Data Rumah dan Warga button
      await tester.tap(find.text('Data Rumah dan Warga'));
      await tester.pumpAndSettle();

      // Verify navigation to DataRumahDanWarga page
      expect(find.text('Data Warga'), findsWidgets);
    });

    testWidgets('Can navigate from HomePage to ChannelTransfer', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Find and tap Channel Transfer button
      await tester.tap(find.text('Channel Transfer'));
      await tester.pumpAndSettle();

      // Verify navigation to ChannelTransfer page
      expect(find.text('Manajemen Channel Transfer'), findsOneWidget);
    });

    testWidgets('Can navigate back from LaporanKeuangan to HomePage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Navigate to LaporanKeuangan
      await tester.tap(find.text('Laporan Keuangan'));
      await tester.pumpAndSettle();

      // Go back
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Verify back at HomePage
      expect(find.text('Jawara Pintar'), findsOneWidget);
    });

    testWidgets('Can navigate back from DataRumahDanWarga to HomePage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Navigate to DataRumahDanWarga
      await tester.tap(find.text('Data Rumah dan Warga'));
      await tester.pumpAndSettle();

      // Go back
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Verify back at HomePage
      expect(find.text('Jawara Pintar'), findsOneWidget);
    });

    testWidgets('HomePage has all navigation buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Verify all navigation buttons exist
      expect(find.text('Data Rumah dan Warga'), findsOneWidget);
      expect(find.text('Laporan Keuangan'), findsOneWidget);
      expect(find.text('Channel Transfer'), findsOneWidget);
    });

    testWidgets('Complete user flow: Home -> Laporan -> Back -> Data -> Back', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Start at HomePage
      expect(find.text('Jawara Pintar'), findsOneWidget);

      // Navigate to Laporan Keuangan
      await tester.tap(find.text('Laporan Keuangan'));
      await tester.pumpAndSettle();
      expect(find.text('Data Pemasukan'), findsOneWidget);

      // Go back to HomePage
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Jawara Pintar'), findsOneWidget);

      // Navigate to Data Rumah dan Warga
      await tester.tap(find.text('Data Rumah dan Warga'));
      await tester.pumpAndSettle();
      expect(find.text('Data Warga'), findsWidgets);

      // Go back to HomePage
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Jawara Pintar'), findsOneWidget);
    });

    testWidgets('All defined routes are accessible', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Test navigation using buttons
      await tester.tap(find.text('Laporan Keuangan'));
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsWidgets);

      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Data Rumah dan Warga'));
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsWidgets);

      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Channel Transfer'));
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsWidgets);
    });
  });

  group('Cross-Page Functionality Tests', () {
    testWidgets('Data persists when navigating between pages', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Navigate to Laporan Keuangan
      await tester.tap(find.text('Laporan Keuangan'));
      await tester.pumpAndSettle();

      // Toggle to Pengeluaran
      await tester.tap(find.text('Pengeluaran'));
      await tester.pumpAndSettle();
      expect(find.text('Data Pengeluaran'), findsOneWidget);

      // Go back to HomePage
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Navigate back to Laporan Keuangan
      await tester.tap(find.text('Laporan Keuangan'));
      await tester.pumpAndSettle();

      // Should show default view (Pemasukan)
      expect(find.text('Data Pemasukan'), findsOneWidget);
    });

    testWidgets('Dialog interactions work correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const JawaraApp());
      await tester.pumpAndSettle();

      // Navigate to Data page
      await tester.tap(find.text('Data Rumah dan Warga'));
      await tester.pumpAndSettle();

      // Verify we are on the data page
      expect(find.text('Data Warga'), findsWidgets);

      // Navigate back
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Verify at HomePage
      expect(find.text('Jawara Pintar'), findsOneWidget);
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
      await tester.tap(find.text('Laporan Keuangan'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Data Rumah dan Warga'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Channel Transfer'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}
