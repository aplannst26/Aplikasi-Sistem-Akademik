import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';

class Detailkrs extends StatelessWidget {
  const Detailkrs({super.key});

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
                    'Detail Krs', // Changed from KTM to KRS
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
            // Header Text
            Text(
              'Detail kartu rencana studi',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            Divider(height: 30 , thickness: 2),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddCourseDialog(context); // Show dialog for adding course
                  },
                  icon: Icon(Icons.add),
                  label: Text('Tambah Mata Kuliah'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 45, 51, 87),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Dropdown for Tahun Akademik
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                    hint: Text('TA'),
                    items: [
                      DropdownMenuItem(value: '2022/2023', child: Text('2022/2023')),
                      // Add more items as needed
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Action for CEK button
                  },
                  child: Text('CEK'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 45, 51, 87),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Table
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(4),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1),
                6: FlexColumnWidth(1),
                7: FlexColumnWidth(1),
                8: FlexColumnWidth(1),
                9: FlexColumnWidth(1),
              },
              children: [
                                _buildTableRow('No', 'Kode MK', 'Mata Kuliah', 'Sks', 'SMT', 'Kelas', 'Uts', 'Nilai', 'Bobot', 'Total', isHeader: true),
                _buildTableRow('1', '210702-12', 'Data Mining', '2', '1', 'A', '-', '-', '-', '-'),
                _buildTableRow('2', '210702-13', 'Rekayasa Web', '3', '1', 'A', '-', '-', '-', '-'),
                _buildTableRow('3', '210702-14', 'Sistem Operasi', '3', '1', 'A', '-', '-', '-', '-'),
                _buildTableRow('4', '210702-15', 'Mobile Computing','3', '1', 'A', '-', '-', '-', '-'),
              ],
            ),
            SizedBox(height: 10),

            // Total SKS and Total Nilai
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total SKS: 9 SKS'),
                Text('Total Nilai: 0'),
              ],
            ),
            SizedBox(height: 20),

            // Print Button (PushButton)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Cetak KHS di-klik');
                  // Add action for printing KHS here
                },
                child: Text('Cetak KHS'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Color.fromARGB(255, 45, 51, 87),
                ),
              ),
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

  // Function to show a dialog for adding a new course
  void _showAddCourseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Mata Kuliah'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Kode MK',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama Mata Kuliah',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'SKS',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to save course details here
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  TableRow _buildTableRow(String no, String kodeMk, String mataKuliah, String Sks, String SMT, String Kelas, String UTS, String Nilai, String Bobot, String Total, {bool isHeader = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(no, style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(kodeMk, style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(mataKuliah, style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
        ),
      ],
    );
  }
}
