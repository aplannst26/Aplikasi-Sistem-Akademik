import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AjuanCutiPage extends StatefulWidget {
  const AjuanCutiPage({Key? key}) : super(key: key);

  @override
  State<AjuanCutiPage> createState() => _AjuanCutiPageState();
}

class _AjuanCutiPageState extends State<AjuanCutiPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _ttlController = TextEditingController();
  final TextEditingController _alasanController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;

  void _submitAjuanCuti() async {
    // Validasi input
    if (_namaController.text.isEmpty ||
        _jenisKelaminController.text.isEmpty ||
        _ttlController.text.isEmpty ||
        _alasanController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua bidang harus diisi!")),
      );
      return;
    }

    // Simpan data ke Firestore
    try {
      await _firestore.collection('ajuan_cuti').add({
        'nama': _namaController.text,
        'jenis_kelamin': _jenisKelaminController.text,
        'tempat_tanggal_lahir': _ttlController.text,
        'alasan': _alasanController.text,
        'tanggal_pengajuan': Timestamp.now(),
      });

      // Tampilkan notifikasi sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pengajuan cuti berhasil diajukan.")),
      );

      // Reset form
      _namaController.clear();
      _jenisKelaminController.clear();
      _ttlController.clear();
      _alasanController.clear();

      // Navigasi ke halaman lain jika diperlukan
      Navigator.pop(context);
    } catch (e) {
      // Tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 51, 87),
        title: const Text("Pengajuan Cuti"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _jenisKelaminController,
                decoration: InputDecoration(
                  labelText: "Jenis Kelamin",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ttlController,
                decoration: InputDecoration(
                  labelText: "Tempat / Tanggal Lahir",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _alasanController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "ALASAN PENGAJUAN CUTI *",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitAjuanCuti,
                  child: const Text("Ajukan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 45, 51, 87),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
