import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbl_jawara_mobile/Pages/data_rumah_dan_warga_page.dart';

void main() {
  group('DataRumahDanWargaPage Widget Tests', () {
    testWidgets('DataRumahDanWargaPage renders correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: DataRumahDanWargaPage()));

      expect(find.byType(FinanceDashboardScreen), findsOneWidget);
    });

    testWidgets('FinanceDashboardScreen displays toggle buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.text('Data Warga'), findsWidgets);
      expect(find.text('Data Rumah'), findsOneWidget);
    });

    testWidgets('Initial view shows Data Warga', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.text('Data Warga'), findsWidgets);
    });

    testWidgets('Can toggle between Data Warga and Data Rumah', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Initial should be Data Warga
      expect(find.text('Data Warga'), findsWidgets);

      // Tap Data Rumah button
      await tester.tap(find.text('Data Rumah'));
      await tester.pumpAndSettle();

      // Should show Data Rumah view
      expect(find.text('Data Rumah / Alamat'), findsOneWidget);
    });

    testWidgets('DataTable displays columns for Data Warga', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.text('NO'), findsOneWidget);
      expect(find.text('NAMA'), findsOneWidget);
      expect(find.text('NIK'), findsOneWidget);
      expect(find.text('KELUARGA'), findsOneWidget);
      expect(find.text('JENIS KELAMIN'), findsOneWidget);
      expect(find.text('STATUS DOMISILI'), findsOneWidget);
      expect(find.text('STATUS HIDUP'), findsOneWidget);
      expect(find.text('AKSI'), findsOneWidget);
    });

    testWidgets('DataTable displays columns for Data Rumah', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Switch to Data Rumah
      await tester.tap(find.text('Data Rumah'));
      await tester.pumpAndSettle();

      expect(find.text('NO'), findsOneWidget);
      expect(find.text('ALAMAT'), findsOneWidget);
      expect(find.text('STATUS'), findsOneWidget);
      expect(find.text('AKSI'), findsOneWidget);
    });

    testWidgets('Sample warga data is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Check for sample warga names
      expect(find.text('warga'), findsOneWidget);
      expect(find.text('GE08T'), findsOneWidget);
    });

    testWidgets('Status chips are displayed correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.text('AKTIF'), findsWidgets);
      expect(find.text('HIDUP'), findsWidgets);
    });

    testWidgets('Action menu button is present', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.byIcon(Icons.more_horiz), findsWidgets);
    });

    testWidgets('Can open action menu popup', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Tap first action menu
      await tester.tap(find.byIcon(Icons.more_horiz).first);
      await tester.pumpAndSettle();

      expect(find.text('Ubah'), findsOneWidget);
      expect(find.text('Hapus'), findsOneWidget);
      expect(find.text('Detail'), findsOneWidget);
    });

    testWidgets('Can open warga detail dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Open action menu
      await tester.tap(find.byIcon(Icons.more_horiz).first);
      await tester.pumpAndSettle();

      // Tap Detail
      await tester.tap(find.text('Detail'));
      await tester.pumpAndSettle();

      expect(find.text('Detail Warga'), findsOneWidget);
    });

    testWidgets('Warga detail dialog displays all fields', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Open detail dialog
      await tester.tap(find.byIcon(Icons.more_horiz).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Detail'));
      await tester.pumpAndSettle();

      expect(find.text('Nama Lengkap:'), findsOneWidget);
      expect(find.text('Jenis Kelamin:'), findsOneWidget);
      expect(find.text('Keluarga:'), findsOneWidget);
      expect(find.text('Status Penduduk:'), findsOneWidget);
    });

    testWidgets('Can close warga detail dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Open detail dialog
      await tester.tap(find.byIcon(Icons.more_horiz).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Detail'));
      await tester.pumpAndSettle();

      expect(find.text('Detail Warga'), findsOneWidget);

      // Close dialog
      await tester.tap(find.text('Tutup'));
      await tester.pumpAndSettle();

      expect(find.text('Detail Warga'), findsNothing);
    });

    testWidgets('Pagination is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('Can tap pagination buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      // Just verify no crash occurs
      expect(find.byType(FinanceDashboardScreen), findsOneWidget);
    });

    testWidgets('AppBar shows add and filter buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
      expect(find.byIcon(Icons.filter_list), findsOneWidget);
    });

    testWidgets('Data Rumah shows correct sample data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Switch to Data Rumah
      await tester.tap(find.text('Data Rumah'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Jln Ir Soekarno'), findsOneWidget);
      expect(find.text('TERSEDIA'), findsWidgets);
      expect(find.text('DITEMPATI'), findsWidgets);
    });

    testWidgets('DataTables are scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      expect(find.byType(SingleChildScrollView), findsWidgets);
    });
  });

  group('DataRumahDanWargaPage Style Tests', () {
    testWidgets('Toggle buttons have correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      final container = tester.widget<Container>(
        find
            .ancestor(
              of: find.text('Data Warga'),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(container.decoration, isA<BoxDecoration>());
    });

    testWidgets('Status chips have color coding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FinanceDashboardScreen()),
      );

      // Verify status chips exist
      expect(find.text('AKTIF'), findsWidgets);
    });
  });
}
