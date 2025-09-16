import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './ajuancuti.dart';
import './HomeScreen.dart';

class PengajuanCutiPage extends StatelessWidget {
  const PengajuanCutiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 51, 87),
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
                    'Pengajuan Cuti',
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "RIWAYAT PENGAJUAN",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('ajuan_cuti')
                              .orderBy('tanggal_pengajuan', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text(
                                  "---- Belum ada riwayat pengajuan ----",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }
                            final data = snapshot.data!.docs;

                            return Column(
                              children: [
                                // Table header
                                Container(
                                  color: const Color.fromARGB(255, 45, 51, 87),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          "No",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Semester",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Tgl Pengajuan",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Penyebab Cuti",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // List of data
                                ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: data.length,
  itemBuilder: (context, index) {
    final item = data[index];
    final itemData = item.data() as Map<String, dynamic>; // Cast ke Map<String, dynamic>

    final semester = itemData.containsKey('semester') ? itemData['semester'] : '-';
    final tanggal = itemData.containsKey('tanggal_pengajuan') && itemData['tanggal_pengajuan'] != null
        ? (itemData['tanggal_pengajuan'] as Timestamp).toDate().toString().split(' ')[0]
        : '-';
    final alasan = itemData.containsKey('alasan') ? itemData['alasan'] : '-';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              "${index + 1}",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              semester,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              tanggal,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              alasan,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  },
),

                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AjuanCutiPage()),
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("AJUKAN CUTI"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 45, 51, 87),
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
