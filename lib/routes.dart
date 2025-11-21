import 'package:flutter/material.dart';
import 'Pages/laporan_keuangan_page.dart';
import 'Pages/home_page.dart';
import 'Pages/data_rumah_dan_warga_page.dart';
import 'Pages/channel_transfer_page.dart';

// Route names
class Routes {
  static const String laporanKeuangan = '/laporan-keuangan';
  static const String home = '/home';
  static const String dataRumahDanWarga = '/data-rumah-dan-warga';
  static const String channelTransfer = '/channel-transfer';
}

// Route mapping
Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomePage(),
  Routes.laporanKeuangan: (context) => const LaporanKeuanganPage(),
  Routes.home: (context) => const HomePage(),
  Routes.dataRumahDanWarga: (context) => const DataRumahDanWargaPage(),
  Routes.channelTransfer: (context) => const ChannelTransferPage(),
};
