import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbl_jawara_mobile/Pages/laporan_keuangan_page.dart';

void main() {
  group('LaporanKeuanganPage Widget Tests', () {
    testWidgets('LaporanKeuanganPage renders correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: LaporanKeuanganPage()));

      expect(find.byType(FinanceDashboardScreen), findsOneWidget);
    });

    testWidgets('FinanceDashboardScreen displays toggle buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.text('Pemasukan'), findsOneWidget);
      expect(find.text('Pengeluaran'), findsOneWidget);
    });

    testWidgets('FinanceDashboardScreen displays AppBar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Can toggle between Pemasukan and Pengeluaran views', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Initial view should be Pemasukan
      expect(find.text('Data Pemasukan'), findsOneWidget);

      // Tap Pengeluaran button
      await tester.tap(find.text('Pengeluaran'));
      await tester.pumpAndSettle();

      // Should now show Pengeluaran view
      expect(find.text('Data Pengeluaran'), findsOneWidget);
    });

    testWidgets('DataTable displays correct columns for Pemasukan', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.text('NO'), findsOneWidget);
      expect(find.text('NAMA'), findsOneWidget);
      expect(find.text('JENIS PEMASUKAN'), findsOneWidget);
      expect(find.text('TANGGAL'), findsOneWidget);
      expect(find.text('NOMINAL'), findsOneWidget);
      expect(find.text('AKSI'), findsOneWidget);
    });

    testWidgets('DataTable displays data rows', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Check if DataTable exists
      expect(find.byType(DataTable), findsOneWidget);

      // Check for some sample data
      expect(find.text('bing ciling'), findsOneWidget);
    });

    testWidgets('Action buttons (edit and detail) are present', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Check for edit icon
      expect(find.byIcon(Icons.edit), findsWidgets);

      // Check for visibility/detail icon
      expect(find.byIcon(Icons.visibility), findsWidgets);
    });

    testWidgets('Detail buttons exist in data table', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Check that detail icons exist (they are off-screen so we just verify existence)
      expect(find.byIcon(Icons.visibility), findsWidgets);
    });

    testWidgets('Edit buttons exist in data table', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Check that edit icons exist
      expect(find.byIcon(Icons.edit), findsWidgets);
    });

    testWidgets('DataTable displays transaction data correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Verify that transaction data is displayed
      expect(find.byType(DataTable), findsOneWidget);
      expect(find.text('bing ciling'), findsOneWidget);
      expect(find.text('Iuran Warga'), findsWidgets);
    });

    testWidgets('Page content is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Check for scrollable widgets
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    testWidgets('Can switch to Pengeluaran and see different column name', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Switch to Pengeluaran
      await tester.tap(find.text('Pengeluaran'));
      await tester.pumpAndSettle();

      expect(find.text('JENIS PENGELUARAN'), findsOneWidget);
    });

    testWidgets('AppBar shows add and filter icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
      expect(find.byIcon(Icons.filter_list), findsOneWidget);
    });
  });

  group('LaporanKeuanganPage Data Tests', () {
    testWidgets('DataTable has horizontal and vertical scroll', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    testWidgets('Sample transaction data is displayed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Check for sample names from mock data
      expect(find.textContaining('bing ciling'), findsOneWidget);
    });
  });
}
