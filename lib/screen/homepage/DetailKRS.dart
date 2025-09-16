import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:academic_mobile/service/api_service.dart';

class Detailkrs extends StatefulWidget {
  const Detailkrs({super.key});

  @override
  State<Detailkrs> createState() => _DetailkrsState();
}

class _DetailkrsState extends State<Detailkrs> {
  late Future<List<Map<String, dynamic>>> _futureKRS;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureKRS = apiService.getKRS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 51, 87),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _futureKRS,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Gagal memuat data KRS'));
            }
            final krsList = (snapshot.data ?? [])
                .where((item) {
                  final status = (item['status'] ?? '').toLowerCase();
                  return status == 'acc' || status == 'approved' || status == 'diterima';
                })
                .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail kartu rencana studi',
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  Divider(height: 30, thickness: 2),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.all(16),
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
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(Color.fromARGB(255, 45, 51, 87)),
                        headingTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        dataRowColor: MaterialStateProperty.all(Colors.white),
                        dataTextStyle: TextStyle(color: Colors.black87, fontSize: 15),
                        columnSpacing: 48, // Lebarkan jarak antar kolom
                        horizontalMargin: 24, // Lebarkan margin kiri-kanan
                        columns: const [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Kode MK')),
                          DataColumn(label: Text('Mata Kuliah')),
                          DataColumn(label: Text('SKS')),
                        ],
                        rows: List.generate(krsList.length, (index) {
                          final mk = krsList[index]['mata_kuliah'];
                          return DataRow(
                            cells: [
                              DataCell(Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text('${index + 1}'),
                              )),
                              DataCell(Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(mk?['kode'] ?? '-'),
                              )),
                              DataCell(Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(mk?['nama'] ?? '-'),
                              )),
                              DataCell(Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(mk?['sks']?.toString() ?? '-'),
                              )),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _generatePdf(krsList);
                      },
                      child: Text('Cetak KRS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Color.fromARGB(255, 45, 51, 87),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _generatePdf(List<Map<String, dynamic>> krsList) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Kartu Rencana Studi',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.Divider(),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                _buildPdfTableRow('No', 'Kode MK', 'Mata Kuliah', 'SKS', isHeader: true),
                ...List.generate(krsList.length, (index) {
                  final mk = krsList[index]['mata_kuliah'];
                  return _buildPdfTableRow(
                    '${index + 1}',
                    mk?['kode'] ?? '-',
                    mk?['nama'] ?? '-',
                    mk?['sks']?.toString() ?? '-',
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  pw.TableRow _buildPdfTableRow(
      String no, String kodeMk, String mataKuliah, String sks,
      {bool isHeader = false}) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Text(no,
              style: pw.TextStyle(
                  fontWeight:
                      isHeader ? pw.FontWeight.bold : pw.FontWeight.normal)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Text(kodeMk,
              style: pw.TextStyle(
                  fontWeight:
                      isHeader ? pw.FontWeight.bold : pw.FontWeight.normal)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Text(mataKuliah,
              style: pw.TextStyle(
                  fontWeight:
                      isHeader ? pw.FontWeight.bold : pw.FontWeight.normal)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Text(sks,
              style: pw.TextStyle(
                  fontWeight:
                      isHeader ? pw.FontWeight.bold : pw.FontWeight.normal)),
        ),
      ],
    );
  }

  TableRow _buildTableRow(
      String no, String kodeMk, String mataKuliah, String sks,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(sks,
              style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
        ),
      ],
    );
  }
}
