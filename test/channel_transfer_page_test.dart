import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbl_jawara_mobile/Pages/channel_transfer_page.dart';

void main() {
  group('ChannelTransferPage Widget Tests', () {
    testWidgets('ChannelTransferPage renders correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferPage()));

      expect(find.byType(ChannelTransferScreen), findsOneWidget);
    });

    testWidgets('Page displays correct title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.text('Manajemen Channel Transfer'), findsOneWidget);
    });

    testWidgets('AppBar displays add and filter buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
      expect(find.byIcon(Icons.filter_list), findsOneWidget);
    });

    testWidgets('DataTable displays correct columns', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.text('NO'), findsOneWidget);
      expect(find.text('NAMA'), findsOneWidget);
      expect(find.text('TIPE'), findsOneWidget);
      expect(find.text('A/N'), findsOneWidget);
      expect(find.text('AKSI'), findsOneWidget);
    });

    testWidgets('DataTable displays sample data', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      // Check for sample channel transfer data
      expect(find.text('QRIS Resmi RT 08'), findsOneWidget);
      expect(find.text('BCA'), findsOneWidget);
      expect(find.text('234234'), findsOneWidget);
      expect(find.text('Transfer via BCA'), findsOneWidget);
    });

    testWidgets('DataTable displays channel types correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.text('qris'), findsOneWidget);
      expect(find.text('bank'), findsWidgets);
      expect(find.text('ewallet'), findsOneWidget);
    });

    testWidgets('DataTable displays A/N (Atas Nama) correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.text('RW 08 Karangploso'), findsOneWidget);
      expect(find.text('jose'), findsOneWidget);
      expect(find.text('23234'), findsOneWidget);
      expect(find.text('RT Jawara Karangploso'), findsOneWidget);
    });

    testWidgets('Action menu button is present for each row', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      // Should have 4 action menu buttons (one per data row)
      expect(find.byIcon(Icons.more_horiz), findsNWidgets(4));
    });

    testWidgets('Action menu popups exist', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      // Verify action menu widgets exist (but don't test tap since they're off-screen)
      expect(find.byType(PopupMenuButton<String>), findsNWidgets(4));
    });

    testWidgets('Add button shows tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      final addButton = find.byIcon(Icons.add_circle_outline);
      expect(addButton, findsOneWidget);

      // Long press to show tooltip
      await tester.longPress(addButton);
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Tambah Data'), findsOneWidget);
    });

    testWidgets('Filter button shows tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      final filterButton = find.byIcon(Icons.filter_list);
      expect(filterButton, findsOneWidget);

      // Long press to show tooltip
      await tester.longPress(filterButton);
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Filter Data'), findsOneWidget);
    });

    testWidgets('Pagination is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('DataTable is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    testWidgets('Card widget wraps the table', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('All channel transfer numbers are displayed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      // Numbers may appear in both data table and pagination
      expect(find.text('1'), findsWidgets);
      expect(find.text('2'), findsWidgets);
      expect(find.text('3'), findsWidgets);
      expect(find.text('4'), findsWidgets);
    });
  });

  group('ChannelTransfer Model Tests', () {
    test('ChannelTransfer model creates instance correctly', () {
      final channel = ChannelTransfer(
        no: 1,
        nama: 'Test Channel',
        tipe: 'test',
        aN: 'Test User',
      );

      expect(channel.no, 1);
      expect(channel.nama, 'Test Channel');
      expect(channel.tipe, 'test');
      expect(channel.aN, 'Test User');
    });

    test('allChannels list contains correct number of items', () {
      expect(allChannels.length, 4);
    });

    test('allChannels contains correct data types', () {
      expect(allChannels[0].tipe, 'qris');
      expect(allChannels[1].tipe, 'bank');
      expect(allChannels[2].tipe, 'ewallet');
      expect(allChannels[3].tipe, 'bank');
    });

    test('allChannels contains correct names', () {
      expect(allChannels[0].nama, 'QRIS Resmi RT 08');
      expect(allChannels[1].nama, 'BCA');
      expect(allChannels[2].nama, '234234');
      expect(allChannels[3].nama, 'Transfer via BCA');
    });
  });

  group('ChannelTransferPage Integration Tests', () {
    testWidgets('Complete page renders without errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferPage()));

      // Verify no exceptions thrown
      expect(tester.takeException(), isNull);
    });

    testWidgets('Page layout is correct', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(DataTable), findsOneWidget);
    });

    testWidgets('Multiple action menus exist', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      // Verify multiple action menu buttons exist
      expect(find.byIcon(Icons.more_horiz), findsNWidgets(4));
      expect(find.byType(PopupMenuButton<String>), findsNWidgets(4));
    });

    testWidgets('AppBar has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.elevation, 4);
      expect(appBar.foregroundColor, Colors.white);
    });
  });

  group('ChannelTransferPage Style Tests', () {
    testWidgets('Table has proper styling', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      final card = tester.widget<Card>(find.byType(Card));
      expect(card.elevation, 4);
    });

    testWidgets('Action buttons are properly styled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ChannelTransferScreen()));

      expect(find.byType(IconButton), findsWidgets);
    });
  });
}
