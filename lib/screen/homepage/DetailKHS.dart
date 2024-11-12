import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';

class DetailKHS extends StatelessWidget {
  const DetailKHS({super.key});

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
                    'Detail KHS', // Changed from KTM to KRS
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail kartu rencana studi',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      Divider(height: 30, thickness: 2),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TA', 
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .indigo[900], // Customize color if needed
                            ),
                          ),
                          // Form Fields
                          DropdownButtonFormField<String>(
                            dropdownColor: Colors.grey,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onChanged: (value) {},
                            items: [
                              DropdownMenuItem(
                                  value: '2022/2023', child: Text('2022/2023')),
                            ],
                          ),

                          const SizedBox(height: 20),

                          ElevatedButton(
                            onPressed: () {
                              // Action for CEK button
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: Text('CEK'),
                          ),

                          SizedBox(height: 20),

                          // Sisa kode tidak berubah...
                          Table(
                            border: TableBorder.all(color: Colors.grey),
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(4),
                            },
                            children: [
                              _buildTableRow('No', 'Kode MK', 'Mata Kuliah',
                                  isHeader: true),
                              _buildTableRow('1', '210702-12', 'Data Mining'),
                              _buildTableRow('2', '210702-13', 'Rekayasa Web'),
                              _buildTableRow(
                                  '3', '210702-14', 'Sistem Operasi'),
                              _buildTableRow(
                                  '4', '210702-15', 'Mobile Computing'),
                            ],
                          ),
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total SKS: 9 SKS'),
                              Text('Total Nilai: 0'),
                            ],
                          ),
                          SizedBox(height: 20),

                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                print('Cetak KHS di-klik');
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                backgroundColor:
                                    Color.fromARGB(255, 45, 51, 87),
                              ),
                              child: Text('Cetak KHS'),
                            ),
                          ),
                        ],
                      ),
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
