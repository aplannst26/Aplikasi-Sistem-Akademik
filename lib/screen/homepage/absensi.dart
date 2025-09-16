import 'package:flutter/material.dart';
import 'package:academic_mobile/service/api_service.dart';
import 'package:intl/intl.dart';

class AbsensiPage extends StatefulWidget {
  final List<Map<String, dynamic>> krsList;
  const AbsensiPage({Key? key, required this.krsList}) : super(key: key);

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  final ApiService apiService = ApiService();
  int? selectedKrsId;
  bool isLoading = false;
  List<Map<String, dynamic>> absensiList = [];
  String selectedStatus = 'hadir'; // deklarasi hanya di sini!
  final List<String> statusList = ['hadir', 'izin', 'sakit', 'alpa'];

  Future<void> fetchAbsensi() async {
    if (selectedKrsId == null) {
      setState(() => absensiList = []);
      return;
    }
    // TODO: Ganti dengan API call jika sudah ada endpoint get absensi by krs_id
    setState(() {
      absensiList = [
        {'tanggal': '2025-07-25', 'status': 'hadir'},
        {'tanggal': '2025-07-26', 'status': 'sakit'},
        {'tanggal': '2025-07-27', 'status': 'izin'},
        {'tanggal': '2025-07-28', 'status': 'alpa'},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absensi Mahasiswa'),
        backgroundColor: const Color(0xFF2D3357),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: selectedKrsId,
              decoration: InputDecoration(
                labelText: 'Pilih Mata Kuliah',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF5F6FA),
              ),
              items: widget.krsList.map((item) {
                final mk = item['mata_kuliah'];
                return DropdownMenuItem<int>(
                  value: item['id'],
                  child: Text('${mk?['nama'] ?? '-'} (${mk?['kode'] ?? '-'})'),
                );
              }).toList(),
              onChanged: (val) async {
                setState(() => selectedKrsId = val);
                await fetchAbsensi();
              },
            ),
            SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF5F6FA),
              ),
              items: statusList.map((status) => DropdownMenuItem(
                value: status,
                child: Text(status),
              )).toList(),
              onChanged: (val) => setState(() => selectedStatus = val!),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D3357),
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: isLoading ? null : () async {
                  if (selectedKrsId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Pilih mata kuliah terlebih dahulu!')),
                    );
                    return;
                  }
                  setState(() => isLoading = true);
                  try {
                    final now = DateTime.now();
                    final tanggal = DateFormat('yyyy-MM-dd').format(now);
                    await apiService.absenMahasiswa(
                      krsId: selectedKrsId!,
                      tanggal: tanggal,
                      status: selectedStatus, // status terbaru
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Absen berhasil!')),
                    );
                    await fetchAbsensi();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal absen: $e')),
                    );
                  }
                  setState(() => isLoading = false);
                },
                child: isLoading ? CircularProgressIndicator() : Text('Absen'),
              ),
            ),
            SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Riwayat Absensi:', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 8),
            Expanded(
              child: absensiList.isEmpty
                  ? Center(child: Text('Belum ada data absensi.'))
                  : ListView.builder(
                      itemCount: absensiList.length,
                      itemBuilder: (context, index) {
                        final absen = absensiList[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: Icon(
                              absen['status'] == 'hadir'
                                  ? Icons.check_circle
                                  : absen['status'] == 'sakit'
                                      ? Icons.healing
                                      : absen['status'] == 'izin'
                                          ? Icons.info
                                          : Icons.cancel,
                              color: absen['status'] == 'hadir'
                                  ? Colors.green
                                  : absen['status'] == 'sakit'
                                      ? Colors.orange
                                      : absen['status'] == 'izin'
                                          ? Colors.blue
                                          : Colors.red,
                            ),
                            title: Text('Tanggal: ${absen['tanggal']}'),
                            subtitle: Text('Status: ${absen['status']}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
