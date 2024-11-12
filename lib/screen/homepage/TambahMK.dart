import 'package:flutter/material.dart';

class TambahMKPage extends StatelessWidget {
  const TambahMKPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah MK"),
        backgroundColor: Color.fromARGB(255, 45, 51, 87),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detail kartu rencana studi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'TA',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text("2023/2024"),
                        value: "2023/2024",
                      ),
                      DropdownMenuItem(
                        child: Text("2024/2025"),
                        value: "2024/2025",
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Semester',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text("Ganjil"),
                        value: "Ganjil",
                      ),
                      DropdownMenuItem(
                        child: Text("Genap"),
                        value: "Genap",
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            // Horizontal scrolling for DataTable
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Kode MK')),
                  DataColumn(label: Text('Mata Kuliah')),
                  DataColumn(label: Text('Sks')),
                  DataColumn(label: Text('Smt')),
                  DataColumn(label: Text('Kelas')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('210702-12')),
                    DataCell(Text('Pemrograman Dasar')),
                    DataCell(Text('3')),
                    DataCell(Text('1')),
                    DataCell(Text('A')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('210702-13')),
                    DataCell(Text('Manajemen Database')),
                    DataCell(Text('3')),
                    DataCell(Text('1')),
                    DataCell(Text('B')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('210702-14')),
                    DataCell(Text('Cyber Security')),
                    DataCell(Text('4')),
                    DataCell(Text('2')),
                    DataCell(Text('A')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('4')),
                    DataCell(Text('210702-15')),
                    DataCell(Text('Animasi')),
                    DataCell(Text('3')),
                    DataCell(Text('2')),
                    DataCell(Text('B')),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
