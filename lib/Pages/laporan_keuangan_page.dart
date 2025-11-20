import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Export the main widget for routing
class LaporanKeuanganPage extends StatelessWidget {
  const LaporanKeuanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FinanceDashboardScreen();
  }
}

// --- ENUM UNTUK TIPE TRANSAKSI ---
enum ViewType { pemasukan, pengeluaran }

// --- MODEL DATA TRANSAKSI ---
class Transaction {
  final int no;
  final String nama;
  final String jenis;
  final DateTime tanggal;
  final double nominal;
  final ViewType type;

  Transaction({
    required this.no,
    required this.nama,
    required this.jenis,
    required this.tanggal,
    required this.nominal,
    required this.type,
  });
}

// --- DATA MOCKUP (CONTOH DATA) ---
final List<Transaction> allTransactions = [
  // Data Pemasukan (sesuai image_3c1588.png)
  Transaction(
    no: 1,
    nama: 'bing ciling',
    jenis: 'Iuran Warga',
    tanggal: DateTime(2025, 11, 17, 23, 02),
    nominal: 10.00,
    type: ViewType.pemasukan,
  ),
  Transaction(
    no: 2,
    nama: 'alhamdulillah kita kaya',
    jenis: 'Donasi',
    tanggal: DateTime(2025, 11, 12, 17, 01),
    nominal: 1.00,
    type: ViewType.pemasukan,
  ),
  Transaction(
    no: 3,
    nama: 'Agustusan',
    jenis: 'Iuran Warga',
    tanggal: DateTime(2025, 10, 27, 20, 34),
    nominal: 15.00,
    type: ViewType.pemasukan,
  ),
  Transaction(
    no: 4,
    nama: 'Uang Kaget',
    jenis: 'Dana Bantuan Pemerintah',
    tanggal: DateTime(2025, 10, 23, 04, 56),
    nominal: 2000000.00,
    type: ViewType.pemasukan,
  ),
  Transaction(
    no: 5,
    nama: 'Joki by firman',
    jenis: 'Pendapatan Lainnya',
    tanggal: DateTime(2025, 8, 13, 00, 55),
    nominal: 49999997.00,
    type: ViewType.pemasukan,
  ),

  // Data Pengeluaran (sesuai image_3c12bc.png)
  Transaction(
    no: 1,
    nama: 'Untuk lomba agustusan paling meriah dunia jagat raya milky way',
    jenis: 'Lain-lain',
    tanggal: DateTime(2025, 11, 12, 19, 00),
    nominal: 1000000000.00,
    type: ViewType.pengeluaran,
  ),
  Transaction(
    no: 2,
    nama: 'Kerja Bakti',
    jenis: 'Pemeliharaan Fasilitas',
    tanggal: DateTime(2025, 10, 19, 20, 26),
    nominal: 50000.00,
    type: ViewType.pengeluaran,
  ),
  Transaction(
    no: 3,
    nama: 'Arka',
    jenis: 'Operasional RT/RW',
    tanggal: DateTime(2025, 10, 17, 02, 31),
    nominal: 6.00,
    type: ViewType.pengeluaran,
  ),
  Transaction(
    no: 4,
    nama: 'adsad',
    jenis: 'Pemeliharaan Fasilitas',
    tanggal: DateTime(2025, 10, 10, 01, 08),
    nominal: 2112.00,
    type: ViewType.pengeluaran,
  ),
];

void main() {
  // Memastikan format mata uang menggunakan titik sebagai pemisah ribuan
  Intl.defaultLocale = 'id';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Keuangan RT/RW',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Mengatur font secara default jika diperlukan, namun menggunakan default Flutter
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const FinanceDashboardScreen(),
    );
  }
}

class FinanceDashboardScreen extends StatefulWidget {
  const FinanceDashboardScreen({super.key});

  @override
  State<FinanceDashboardScreen> createState() => _FinanceDashboardScreenState();
}

class _FinanceDashboardScreenState extends State<FinanceDashboardScreen> {
  ViewType _currentView = ViewType.pemasukan; // Tampilan awal adalah Pemasukan

  @override
  Widget build(BuildContext context) {
    // Filter data berdasarkan tampilan saat ini
    final List<Transaction> filteredData = allTransactions
        .where((t) => t.type == _currentView)
        .toList();

    // Judul yang akan ditampilkan di halaman
    final String pageTitle = _currentView == ViewType.pemasukan
        ? 'Data Pemasukan'
        : 'Data Pengeluaran';

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        backgroundColor: Colors.indigo.shade600,
        foregroundColor: Colors.white,
        actions: [
          // Tombol untuk Aksi Tambah/Filter (mirip ikon di gambar)
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              _showSnackbar(
                'Aksi Tambah ${_currentView == ViewType.pemasukan ? "Pemasukan" : "Pengeluaran"}',
              );
            },
            tooltip: 'Tambah Data',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showSnackbar('Aksi Filter');
            },
            tooltip: 'Filter Data',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- TOMBOL UNTUK MEMILIH TAMPILAN (Toggle) ---
            _buildViewToggleButton(),
            const SizedBox(height: 20),

            // --- WIDGET TABEL DATA ---
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildTransactionDataTable(filteredData),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk tombol toggle Pemasukan/Pengeluaran
  Widget _buildViewToggleButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(label: 'Pemasukan', type: ViewType.pemasukan),
          _buildToggleButton(label: 'Pengeluaran', type: ViewType.pengeluaran),
        ],
      ),
    );
  }

  // Tombol individual dalam toggle
  Widget _buildToggleButton({required String label, required ViewType type}) {
    final bool isSelected = _currentView == type;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentView = type;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.indigo : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.indigo : Colors.transparent,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.indigo.shade700,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan DataTable
  Widget _buildTransactionDataTable(List<Transaction> data) {
    // Tentukan judul kolom Jenis berdasarkan ViewType
    final String jenisColumnTitle = _currentView == ViewType.pemasukan
        ? 'JENIS PEMASUKAN'
        : 'JENIS PENGELUARAN';

    // Format mata uang Rupiah
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 2,
    );

    return DataTable(
      // Properti DataTable untuk tampilan seperti gambar
      // headerRowHeight: 48,
      dataRowMinHeight: 60,
      dataRowMaxHeight: 60,
      headingRowColor: WidgetStateProperty.resolveWith(
        (states) => Colors.indigo.shade50,
      ),
      columns: [
        const DataColumn(
          label: Text('NO', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const DataColumn(
          label: Text('NAMA', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text(
            jenisColumnTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const DataColumn(
          label: Text('TANGGAL', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const DataColumn(
          label: Text(
            'NOMINAL',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
        const DataColumn(
          label: Text('AKSI', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
      rows: data.map((item) {
        return DataRow(
          cells: [
            DataCell(Text(item.no.toString())),
            DataCell(
              // Wrap text to display long name gracefully
              SizedBox(
                width:
                    200, // Lebar fixed untuk kolom nama agar tidak terlalu lebar
                child: Text(
                  item.nama,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            DataCell(Text(item.jenis)),
            DataCell(
              Text(DateFormat('dd MMM yyyy HH:mm').format(item.tanggal)),
            ), // Format tanggal
            DataCell(
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  currencyFormatter.format(item.nominal), // Format nominal
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _currentView == ViewType.pemasukan
                        ? Colors.green.shade700
                        : Colors.red.shade700,
                  ),
                ),
              ),
            ),
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      _handleAction('edit', item);
                    },
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    icon: const Icon(Icons.visibility, color: Colors.green),
                    onPressed: () {
                      _showDetailDialog(item);
                    },
                    tooltip: 'Lihat Detail',
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // Fungsi untuk menangani aksi Edit
  void _handleAction(String action, Transaction item) {
    _showSnackbar('Aksi: $action pada ${item.nama}');
    // Di sini Anda akan menambahkan logika CRUD yang sesungguhnya (misalnya, menampilkan dialog ubah)
  }

  // Fungsi untuk menampilkan detail dialog
  void _showDetailDialog(Transaction item) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    final dateFormatter = DateFormat('yyyy-MM-dd');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail ${_currentView == ViewType.pemasukan ? "Pemasukan" : "Pengeluaran"}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDetailRow(
                    'Nama ${_currentView == ViewType.pemasukan ? "Pemasukan" : "Pengeluaran"}',
                    item.nama,
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow('Kategori', item.jenis),
                  const SizedBox(height: 16),
                  _buildDetailRow('Keluarga', 'Keluarga GE08T'),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    'Periode',
                    dateFormatter.format(item.tanggal),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    'Jumlah',
                    currencyFormatter.format(item.nominal),
                    valueColor: _currentView == ViewType.pemasukan
                        ? Colors.green
                        : Colors.red,
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow('Verifikator', 'Admin Jawara'),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bukti ${_currentView == ViewType.pemasukan ? "Pemasukan" : "Pengeluaran"}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Tutup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper widget untuk menampilkan baris detail
  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }

  // Fungsi untuk menampilkan Snackbar (pengganti dialog/alert sederhana)
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
