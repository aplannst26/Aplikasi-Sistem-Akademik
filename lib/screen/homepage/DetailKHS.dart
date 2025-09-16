import 'dart:ffi';

import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:academic_mobile/service/api_service.dart';

class DetailKHS extends StatefulWidget {
  const DetailKHS({super.key});

  @override
  State<DetailKHS> createState() => _DetailKHSState();
}

class _DetailKHSState extends State<DetailKHS> {
  late Future<List<Map<String, dynamic>>> _futureKHS;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureKHS = apiService.getKHS();
  }

  @override
  Widget build(BuildContext context) {
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
                    'Detail KHS',
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
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _futureKHS,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Gagal memuat data KHS'));
                    }
                    final khsList = snapshot.data ?? [];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Kode MK')),
                          DataColumn(label: Text('Mata Kuliah')),
                          DataColumn(label: Text('SKS')),
                          DataColumn(label: Text('Smt')),
                          DataColumn(label: Text('Kelas')),
                          DataColumn(label: Text('Tugas')),
                          DataColumn(label: Text('UTS')),
                          DataColumn(label: Text('UAS')),
                          DataColumn(label: Text('Akhir')),
                          DataColumn(label: Text('Grade')),
                        ],
                        rows: List.generate(khsList.length, (index) {
                          final mk = khsList[index]['mata_kuliah'];
                          return DataRow(
                            cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(Text(mk?['kode'] ?? '-')),
                              DataCell(Text(mk?['nama'] ?? '-')),
                              DataCell(Text(mk?['sks']?.toString() ?? '-')),
                              DataCell(Text(mk?['semester']?.toString() ?? '-')),
                              DataCell(Text(mk?['kelas'] ?? '-')),
                              DataCell(Text(khsList[index]['nilai_tugas']?.toString() ?? '-')),
                              DataCell(Text(khsList[index]['nilai_uts']?.toString() ?? '-')),
                              DataCell(Text(khsList[index]['nilai_uas']?.toString() ?? '-')),
                              DataCell(Text(khsList[index]['nilai_akhir']?.toString() ?? '-')),
                              DataCell(Text(khsList[index]['grade']?.toString() ?? '-')),
                            ],
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Kartu Hasil Studi',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  _buildPdfTableRow('No', 'Kode MK', 'Mata Kuliah', 'Sks', 'Smt', 'Kelas', 'Uts', 'Nilai', 'Bobot', 'Total'),
                  _buildPdfTableRow('1', '210702-12', 'Data Mining', '2', '1', 'A', '', '', '', ''),
                  _buildPdfTableRow('2', '210702-13', 'Rekayasa Web', '2', '1', 'A', '', '', '', ''),
                  _buildPdfTableRow('3', '210702-14', 'Sistem Operasi', '2', '1', 'c', '', '', '', ''),
                  _buildPdfTableRow('4', '210702-15', 'Mobile Computing', '2', '1', 'B', '', '', '', ''),
                ],
              ),
          ],
        ),
      ),
    );
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  pw.TableRow _buildPdfTableRow(
    String no, String KodeMK, String MataKuliah, String Sks, String Smt, String Kelas, String Uts, String Nilai, String Bobot, String Total,
     {bool isHeader = false}) {
      return pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(no,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(KodeMK,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(MataKuliah,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(Sks,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(Smt,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(Kelas,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(Uts,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(Nilai,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(Bobot,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(Total,
                style: pw.TextStyle(
                  fontWeight: isHeader? pw.FontWeight.bold : pw.FontWeight.normal)),
          ),
        ],
      );
     }

  TableRow _buildTableRow(String no, String kodeMk, String mataKuliah,
      {bool isHeader = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(no,
              style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(kodeMk,
              style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(mataKuliah,
              style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
        ),
      ],
    );
  }
}
