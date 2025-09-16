import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io'; // Added for File
import 'dart:convert'; // Added for jsonDecode
import 'package:academic_mobile/service/api_service.dart';

class UploadTugasPage extends StatefulWidget {
  final List<Map<String, dynamic>> krsList; // Daftar MK yang diambil
  final String baseUrl;
  const UploadTugasPage({required this.krsList, required this.baseUrl, super.key});

  @override
  State<UploadTugasPage> createState() => _UploadTugasPageState();
}

class _UploadTugasPageState extends State<UploadTugasPage> {
  int? selectedKrsId;
  PlatformFile? selectedFile;
  bool isLoading = false;
  final TextEditingController _judulController = TextEditingController();
  final ApiService apiService = ApiService();

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'zip', 'rar'],
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  Future<void> submit() async {
    if (selectedKrsId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pilih mata kuliah terlebih dahulu!')));
      return;
    }
    if (selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pilih file tugas terlebih dahulu!')));
      return;
    }
    setState(() => isLoading = true);
    try {
      await apiService.uploadTugasMahasiswa(
        krsId: selectedKrsId!,
        file: File(selectedFile!.path!),
        judul: _judulController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tugas berhasil diupload!')));
      setState(() {
        selectedFile = null;
        _judulController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal upload tugas: $e')));
    }
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _judulController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.krsList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Anda belum mengambil mata kuliah. Silakan ambil KRS terlebih dahulu.')),
      );
      return Scaffold(
        appBar: AppBar(title: Text('Upload Tugas')),
        body: Center(
          child: Text('Anda belum mengambil mata kuliah. Silakan ambil KRS terlebih dahulu.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Tugas'),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int>(
              value: selectedKrsId,
              decoration: InputDecoration(
                labelText: 'Pilih Mata Kuliah',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF5F6FA),
              ),
              items: widget.krsList.map<DropdownMenuItem<int>>((krs) {
                final mk = krs['mata_kuliah'] as Map<String, dynamic>?;
                return DropdownMenuItem<int>(
                  value: krs['id'] as int?,
                  child: Text('${mk?['nama'] ?? '-'} (${mk?['kode'] ?? '-'})'),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedKrsId = val),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                labelText: 'Judul Tugas (opsional)',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF5F6FA),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2D3357),
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: pickFile,
              icon: Icon(Icons.attach_file),
              label: Text(selectedFile == null ? 'Pilih File (.pdf, .doc, .zip, .rar)' : selectedFile!.name),
            ),
            SizedBox(height: 16),
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
                onPressed: isLoading ? null : submit,
                child: isLoading
                    ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text('Upload Tugas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
