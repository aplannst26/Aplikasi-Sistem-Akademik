import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:academic_mobile/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:academic_mobile/service/api_service.dart';
import 'package:academic_mobile/model/mahasiswa_profile.dart';

class KTMPage extends StatefulWidget {
  const KTMPage({Key? key}) : super(key: key);

  @override
  _KTMPageState createState() => _KTMPageState();
}

class _KTMPageState extends State<KTMPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _fakultasController = TextEditingController();
  final TextEditingController _prodiController = TextEditingController();
  final ApiService apiService = ApiService();
  String? _semester;
  String? _tahunMasuk;
  String? _email;

  @override
  void initState() {
    super.initState();
    fetchMahasiswaData();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _fakultasController.dispose();
    _prodiController.dispose();
    super.dispose();
  }

  Future<void> fetchMahasiswaData() async {
    try {
      MahasiswaProfile profile = await apiService.getMahasiswaProfile();
      setState(() {
        _namaController.text = profile.user.namaLengkap;
        _nimController.text = profile.nim;
        _fakultasController.text = profile.fakultas;
        _prodiController.text = profile.programStudi;
        _semester = profile.semester.toString();
        _tahunMasuk = profile.tahunMasuk;
        _email = profile.user.email;
      });
    } catch (e) {
      // Tampilkan error jika perlu
    }
  }

  Future<void> _createAndPrintPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'KARTU TANDA MAHASISWA',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Nama Lengkap: ${_namaController.text}'),
              pw.Text('Nim: ${_nimController.text}'),
              pw.Text('Fakultas: ${_fakultasController.text}'),
              pw.Text('Prodi: ${_prodiController.text}')
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  Future<void> _saveProfile() async {
    try {
      await apiService.updateMahasiswaProfile(
        namaLengkap: _namaController.text,
        email: _email ?? '', // Ambil dari profile
        nim: _nimController.text,
        fakultas: _fakultasController.text,
        prodi: _prodiController.text,
        semester: _semester ?? '',
        tahunMasuk: _tahunMasuk ?? '',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil disimpan!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data!')),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
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
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                  ),
                  const Text(
                    'KTM',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      'KARTU TANDA MAHASISWA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 45, 51, 87),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // KTM Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/ktm.png',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Nama Lengkap',
                        style:
                            TextStyle(color: Color.fromARGB(255, 45, 51, 87)),
                      ),
                    ),
                    const SizedBox(height: 0),
                    TextFormField(
                      controller: _namaController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Nim',
                        style:
                            TextStyle(color: Color.fromARGB(255, 45, 51, 87)),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _nimController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Fakultas',
                        style:
                            TextStyle(color: Color.fromARGB(255, 45, 51, 87)),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _fakultasController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Prodi',
                        style:
                            TextStyle(color: Color.fromARGB(255, 45, 51, 87)),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _prodiController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Print Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createAndPrintPdf,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Cetak KTM',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconCard({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColor.primary,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
