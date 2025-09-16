import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:academic_mobile/model/mahasiswa_profile.dart';
import 'package:academic_mobile/service/api_service.dart';

class Biodata extends StatefulWidget {
  const Biodata({super.key});

  @override
  State<Biodata> createState() => _BiodataState();
}

class _BiodataState extends State<Biodata> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _ttlController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _prodiController = TextEditingController();
  final TextEditingController _fakultasController = TextEditingController();
  final TextEditingController _tahunMasukController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _emailKampusController = TextEditingController();
  final TextEditingController _nomorHpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      MahasiswaProfile profile = await _apiService.getMahasiswaProfile();
      setState(() {
        _namaController.text = profile.user.namaLengkap;
        _nimController.text = profile.nim ?? '';
        _prodiController.text = profile.programStudi ?? '';
        _fakultasController.text = profile.fakultas ?? '';
        _tahunMasukController.text = profile.tahunMasuk?.toString() ?? '';
        _semesterController.text = profile.semester?.toString() ?? '';
        _statusController.text = profile.status ?? '';
        _emailKampusController.text = profile.user.email ?? '';
        _nomorHpController.text = '';
        _alamatController.text = '';
        _jenisKelaminController.text = '';
        _ttlController.text = '';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await _apiService.updateMahasiswaProfile(
        namaLengkap: _namaController.text,
        email: _emailKampusController.text,
        nim: _nimController.text,
        fakultas: _fakultasController.text,
        prodi: _prodiController.text,
        semester: _semesterController.text,
        tahunMasuk: _tahunMasukController.text,
        jenisKelamin: _jenisKelaminController.text,
        ttl: _ttlController.text,
        nomorHp: _nomorHpController.text,
        alamat: _alamatController.text,
      );
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Biodata berhasil disimpan')),
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan biodata: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color.fromARGB(255, 45, 51, 87),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 51, 87),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                  const Text(
                    'Biodata',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // BIODATA Section
                      const Text(
                        'BIODATA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 51, 87),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildLabel('Nama Lengkap'),
                      _buildTextField(_namaController),
                      const SizedBox(height: 16),

                      _buildLabel('Jenis Kelamin'),
                      _buildTextField(_jenisKelaminController),
                      const SizedBox(height: 16),

                      _buildLabel('Tempat / Tanggal Lahir'),
                      _buildTextField(_ttlController),
                      const SizedBox(height: 32),

                      // KEMAHASISWAAN Section
                      Divider(
                        height: 30,
                        thickness: 2,
                      ),
                      const Text(
                        'KEMAHASISWAAN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 51, 87),
                        ),
                      ),
                      Divider(
                        height: 30,
                        thickness: 2,
                      ),
                      const SizedBox(height: 16),

                      _buildLabel('Nama Lengkap'),
                      _buildTextField(_namaController),
                      const SizedBox(height: 16),

                      _buildLabel('NIM'),
                      _buildTextField(_nimController),
                      const SizedBox(height: 16),

                      _buildLabel('Program Studi'),
                      _buildTextField(_prodiController, enabled: false),
                      const SizedBox(height: 16),

                      _buildLabel('Fakultas'),
                      _buildTextField(_fakultasController, enabled: false),
                      const SizedBox(height: 16),

                      _buildLabel('Tahun Masuk'),
                      _buildTextField(_tahunMasukController, enabled: false),
                      const SizedBox(height: 16),

                      _buildLabel('Semester Aktif'),
                      _buildTextField(_semesterController),
                      const SizedBox(height: 16),

                      _buildLabel('Status Mahasiswa'),
                      _buildTextField(_statusController),
                      const SizedBox(height: 16),

                      _buildLabel('Email Kampus'),
                      _buildTextField(_emailKampusController),
                      const SizedBox(height: 16),

                      _buildLabel('Nomor HP (opsional)'),
                      _buildTextField(_nomorHpController),
                      const SizedBox(height: 16),

                      _buildLabel('Alamat (opsional)'),
                      _buildTextField(_alamatController),
                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 45, 51, 87),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: _saveProfile,
                          child: Text('Simpan', style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 89, 96, 139),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {bool enabled = true}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
