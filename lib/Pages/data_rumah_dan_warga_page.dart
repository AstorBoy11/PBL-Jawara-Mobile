import 'package:flutter/material.dart';

// --- ENUM UNTUK TIPE TAMPILAN (Dua CRUD yang Berbeda) ---
enum ViewType { warga, rumah }

// --- MODEL DATA WARGA ---
class Warga {
  final int no;
  final String nama;
  final String nik;
  final String keluarga;
  final String jenisKelamin;
  final String statusDomisili;
  final String statusHidup;

  Warga({
    required this.no,
    required this.nama,
    required this.nik,
    required this.keluarga,
    required this.jenisKelamin,
    required this.statusDomisili,
    required this.statusHidup,
  });
}

// --- MODEL DATA RUMAH/ALAMAT ---
class Rumah {
  final int no;
  final String alamat;
  final String status;

  Rumah({required this.no, required this.alamat, required this.status});
}

// --- DATA MOCKUP (CONTOH DATA WARGA) ---
final List<Warga> allWarga = [
  Warga(
    no: 1,
    nama: 'warga',
    nik: '081111111111',
    keluarga: 'Keluarga warga',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 2,
    nama: 'GE08T',
    nik: '3123456789123456',
    keluarga: 'Keluarga GE08T',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Nonaktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 3,
    nama: 'Jennie',
    nik: '3573034501234567',
    keluarga: 'Keluarga Jennie',
    jenisKelamin: 'Perempuan',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 4,
    nama: 'Agus',
    nik: '20000000000002',
    keluarga: 'Keluarga Agus',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 5,
    nama: 'Cakra',
    nik: '1234567890987654',
    keluarga: 'Keluarga Cakra',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 6,
    nama: 'arara',
    nik: '3514170000088888',
    keluarga: 'Keluarga arara',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 7,
    nama: 'Colette Irwin',
    nik: '1234567891234567',
    keluarga: 'Keluarga Colette Irwin',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 8,
    nama: 'gw warga',
    nik: '3512121212121212',
    keluarga: 'Keluarga gw warga',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 9,
    nama: 'sp',
    nik: '1231231231231231',
    keluarga: 'Keluarga sp',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
  Warga(
    no: 10,
    nama: 'w2',
    nik: '1234567890123456',
    keluarga: 'Keluarga warga1',
    jenisKelamin: 'Laki-laki',
    statusDomisili: 'Aktif',
    statusHidup: 'Hidup',
  ),
];

// --- DATA MOCKUP (CONTOH DATA RUMAH) ---
final List<Rumah> allRumah = [
  Rumah(no: 1, alamat: '12345', status: 'Tersedia'),
  Rumah(no: 2, alamat: 'Jln Ir Soekarno no 6', status: 'Ditempati'),
  Rumah(no: 3, alamat: 'TESTING 12345', status: 'Ditempati'),
  Rumah(no: 4, alamat: 'test123', status: 'Ditempati'),
  Rumah(no: 5, alamat: 'abc 123', status: 'Ditempati'),
  Rumah(no: 6, alamat: 'Blok 2B', status: 'Ditempati'),
  Rumah(no: 7, alamat: 'JL Merpati 06', status: 'Ditempati'),
  Rumah(no: 8, alamat: 'Blok 2C / No.22', status: 'Ditempati'),
  Rumah(no: 9, alamat: 'Aute aspernatur veli', status: 'Ditempati'),
  Rumah(no: 10, alamat: 'adasd', status: 'Ditempati'),
];

// Export the main widget for routing
class DataRumahDanWargaPage extends StatelessWidget {
  const DataRumahDanWargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FinanceDashboardScreen();
  }
}

// Widget utama yang menampung kedua tabel
class FinanceDashboardScreen extends StatefulWidget {
  const FinanceDashboardScreen({super.key});

  @override
  State<FinanceDashboardScreen> createState() => _FinanceDashboardScreenState();
}

class _FinanceDashboardScreenState extends State<FinanceDashboardScreen> {
  ViewType _currentView = ViewType.warga; // Tampilan awal adalah Data Warga

  @override
  Widget build(BuildContext context) {
    // Judul yang akan ditampilkan di halaman
    final String pageTitle = _currentView == ViewType.warga
        ? 'Data Warga'
        : 'Data Rumah / Alamat';

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
              _showSnackbar(
                'Aksi Tambah ${_currentView == ViewType.warga ? "Warga" : "Rumah"}',
              );
            },
            tooltip: 'Tambah Data',
          ),
          // Tombol untuk Aksi Filter (mirip ikon di gambar)
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
            // --- TOMBOL UNTUK MEMILIH TAMPILAN (Toggle) ---
            _buildViewToggleButton(),
            const SizedBox(height: 20),

            // --- WIDGET TABEL DATA (Warga atau Rumah) ---
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
                    child: _currentView == ViewType.warga
                        ? _buildWargaDataTable(allWarga)
                        : _buildRumahDataTable(allRumah),
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

  // Widget untuk tombol toggle Warga/Rumah
  Widget _buildViewToggleButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          _buildToggleButton(label: 'Data Warga', type: ViewType.warga),
          _buildToggleButton(label: 'Data Rumah', type: ViewType.rumah),
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
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade700 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.blue.shade700,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // --- TABEL DATA WARGA ---
  Widget _buildWargaDataTable(List<Warga> data) {
    return DataTable(
      dataRowMinHeight: 48,
      dataRowMaxHeight: 48,
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
          label: Text('NIK', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text(
            'KELUARGA',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'JENIS KELAMIN',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'STATUS DOMISILI',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'STATUS HIDUP',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
            DataCell(Text(item.nik)),
            DataCell(Text(item.keluarga)),
            DataCell(Text(item.jenisKelamin)),
            DataCell(
              _buildStatusChip(item.statusDomisili, Colors.green),
            ), // Status Domisili
            DataCell(
              _buildStatusChip(item.statusHidup, Colors.green),
            ), // Status Hidup
            DataCell(_buildActionMenu(item)),
          ],
        );
      }).toList(),
    );
  }

  // --- TABEL DATA RUMAH/ALAMAT ---
  Widget _buildRumahDataTable(List<Rumah> data) {
    return DataTable(
      dataRowMinHeight: 48,
      dataRowMaxHeight: 48,
      headingRowColor: WidgetStateProperty.resolveWith(
        (states) => Colors.blue.shade50,
      ),
      columns: const [
        DataColumn(
          label: Text('NO', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('ALAMAT', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('STATUS', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('AKSI', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
      rows: data.map((item) {
        Color color = item.status == 'Tersedia' ? Colors.green : Colors.blue;
        return DataRow(
          cells: [
            DataCell(Text(item.no.toString())),
            DataCell(
              SizedBox(
                width: 250,
                child: Text(
                  item.alamat,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            DataCell(_buildStatusChip(item.status, color)), // Status Rumah
            DataCell(_buildActionMenu(item)),
          ],
        );
      }).toList(),
    );
  }

  // Widget Helper untuk Chip Status (Aktif/Nonaktif/Tersedia/Ditempati)
  Widget _buildStatusChip(String status, Color defaultColor) {
    Color chipColor = defaultColor;
    if (status == 'Nonaktif') {
      chipColor = Colors.red;
    } else if (status == 'Ditempati') {
      chipColor = Colors.blue;
    } else if (status == 'Tersedia') {
      chipColor = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColor.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: chipColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Widget Helper untuk Menu Aksi (3 titik)
  Widget _buildActionMenu(dynamic item) {
    String itemName = item is Warga ? item.nama : (item as Rumah).alamat;
    String itemType = item is Warga ? 'Warga' : 'Rumah';

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz),
      onSelected: (String result) {
        if (result == 'detail' && item is Warga) {
          _showWargaDetailDialog(item);
        } else {
          _handleAction(result, itemType, itemName);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(value: 'edit', child: Text('Ubah')),
        const PopupMenuItem<String>(value: 'delete', child: Text('Hapus')),
        const PopupMenuItem<String>(value: 'detail', child: Text('Detail')),
      ],
    );
  }

  // Fungsi untuk menampilkan detail dialog untuk Warga
  void _showWargaDetailDialog(Warga warga) {
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
                  const Text(
                    'Detail Warga',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  _buildDetailRow('Nama Lengkap:', warga.nama),
                  const SizedBox(height: 16),
                  _buildDetailRow('Tempat, Tanggal Lahir:', ','),
                  const SizedBox(height: 16),
                  _buildDetailRow('Nomor telepon:', warga.nik),
                  const SizedBox(height: 16),
                  _buildDetailRow('Jenis Kelamin:', warga.jenisKelamin),
                  const SizedBox(height: 16),
                  _buildDetailRow('Agama:', ''),
                  const SizedBox(height: 16),
                  _buildDetailRow('Golongan Darah:', ''),
                  const SizedBox(height: 16),
                  _buildDetailRow('Pendidikan Terakhir:', ''),
                  const SizedBox(height: 16),
                  _buildDetailRow('Pekerjaan:', ''),
                  const SizedBox(height: 16),
                  _buildDetailRow('Peran dalam Keluarga:', 'Kepala Keluarga'),
                  const SizedBox(height: 16),
                  _buildDetailRow('Status Penduduk:', warga.statusDomisili),
                  const SizedBox(height: 16),
                  _buildDetailRow('Keluarga:', warga.keluarga),
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
  Widget _buildDetailRow(String label, String value) {
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
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
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
