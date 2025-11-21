import 'package:flutter/material.dart';

// --- MODEL DATA CHANNEL TRANSFER (Sesuai Gambar) ---
class ChannelTransfer {
  final int no;
  final String nama;
  final String tipe;
  final String aN; // A/N = Atas Nama
  // Aksi diwakili dengan 3 titik (...), tidak perlu menjadi field data

  ChannelTransfer({
    required this.no,
    required this.nama,
    required this.tipe,
    required this.aN,
  });
}

// --- DATA MOCKUP (CONTOH DATA CHANNEL TRANSFER) ---
final List<ChannelTransfer> allChannels = [
  ChannelTransfer(
    no: 1,
    nama: 'QRIS Resmi RT 08',
    tipe: 'qris',
    aN: 'RW 08 Karangploso',
  ),
  ChannelTransfer(no: 2, nama: 'BCA', tipe: 'bank', aN: 'jose'),
  ChannelTransfer(no: 3, nama: '234234', tipe: 'ewallet', aN: '23234'),
  ChannelTransfer(
    no: 4,
    nama: 'Transfer via BCA',
    tipe: 'bank',
    aN: 'RT Jawara Karangploso',
  ),
  // Tambahkan data lain jika diperlukan
];

// Export the main widget for routing
class ChannelTransferPage extends StatelessWidget {
  const ChannelTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengganti FinanceDashboardScreen dengan ChannelTransferScreen
    return const ChannelTransferScreen();
  }
}

// Widget utama yang menampilkan tabel Channel Transfer
class ChannelTransferScreen extends StatefulWidget {
  const ChannelTransferScreen({super.key});

  @override
  State<ChannelTransferScreen> createState() => _ChannelTransferScreenState();
}

class _ChannelTransferScreenState extends State<ChannelTransferScreen> {
  // Hanya menampilkan satu tipe tabel, jadi ViewType dan toggle tidak diperlukan
  // Judul yang akan ditampilkan di halaman
  final String pageTitle = 'Manajemen Channel Transfer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          // Tombol untuk Aksi Tambah
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              _showSnackbar('Aksi Tambah Channel Transfer');
            },
            tooltip: 'Tambah Data',
          ),
          // Tombol untuk Aksi Filter
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.filter_list, color: Colors.blue.shade700),
              onPressed: () {
                _showSnackbar('Aksi Filter');
              },
              tooltip: 'Filter Data',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Konten filter/pencarian jika ada (ditiadakan untuk fokus ke tabel)
            // const SizedBox(height: 20),

            // --- WIDGET TABEL DATA CHANNEL TRANSFER ---
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
                    // Memanggil fungsi untuk membangun tabel Channel Transfer
                    child: _buildChannelTransferDataTable(allChannels),
                  ),
                ),
              ),
            ),

            // Placeholder Paginasi (sesuai dengan gambar)
            _buildPagination(),
          ],
        ),
      ),
    );
  }

  // --- TABEL DATA CHANNEL TRANSFER ---
  Widget _buildChannelTransferDataTable(List<ChannelTransfer> data) {
    return DataTable(
      // Min dan Max height disesuaikan agar gambar thumbnail muat
      dataRowMinHeight: 60,
      dataRowMaxHeight: 80,
      headingRowColor: WidgetStateProperty.resolveWith(
        (states) => Colors.blue.shade50,
      ),
      columns: const [
        DataColumn(
          label: Text('NO', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('NAMA', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('TIPE', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('A/N', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('AKSI', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
      rows: data.map((item) {
        return DataRow(
          cells: [
            DataCell(Text(item.no.toString())),
            DataCell(Text(item.nama)),
            DataCell(Text(item.tipe)),
            DataCell(Text(item.aN)),
            DataCell(_buildActionMenu(item)),
          ],
        );
      }).toList(),
    );
  }

  // Widget Helper untuk Menu Aksi (3 titik)
  Widget _buildActionMenu(ChannelTransfer item) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz),
      onSelected: (String result) {
        _handleAction(result, 'Channel Transfer', item.nama);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(value: 'edit', child: Text('Ubah')),
        const PopupMenuItem<String>(value: 'delete', child: Text('Hapus')),
        const PopupMenuItem<String>(value: 'detail', child: Text('Detail')),
      ],
    );
  }

  // Fungsi untuk menangani aksi (Ubah/Hapus/Detail)
  void _handleAction(String action, String type, String name) {
    _showSnackbar('Aksi: $action pada Data $type: $name');
    // Di sini Anda akan menambahkan logika CRUD yang sesungguhnya
  }

  // Widget Placeholder Paginasi (sesuai gambar)
  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              _showSnackbar('Halaman Sebelumnya');
            },
          ),
          _buildPageNumber(1, true),
          // Tombol paginasi lain
          _buildPageNumber(2, false),
          _buildPageNumber(3, false),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('...'),
          ),
          _buildPageNumber(4, false),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              _showSnackbar('Halaman Selanjutnya');
            },
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk tombol angka halaman
  Widget _buildPageNumber(int page, bool isCurrent) {
    return InkWell(
      onTap: () {
        _showSnackbar('Halaman $page');
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(minWidth: 40),
        decoration: BoxDecoration(
          color: isCurrent ? Colors.blue.shade700 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isCurrent ? Colors.blue.shade700 : Colors.grey.shade300,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          page.toString(),
          style: TextStyle(
            color: isCurrent ? Colors.white : Colors.black,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan Snackbar (pengganti dialog/alert sederhana)
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
