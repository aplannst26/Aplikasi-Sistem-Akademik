import 'package:academic_mobile/screen/homepage/DetailKRS.dart';
import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:academic_mobile/service/api_service.dart';

class Krspage extends StatefulWidget {
  @override
  _KrspageState createState() => _KrspageState();
}

class _KrspageState extends State<Krspage> {
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
                    'KRS',
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
                  future: _futureKRS,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Gagal memuat data KRS'));
                    }
                    final krsList = snapshot.data ?? [];
                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        const Text(
                          'Kartu Rencana Studi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 45, 51, 87),
                          ),
                        ),
                        Divider(height: 30, thickness: 2),
                        const SizedBox(height: 16),
                        // Info KRS bisa diambil dari krsList[0] jika ada, atau tampilkan statis
                        // Mata Kuliah
                        const Text(
                          'Daftar Mata Kuliah yang Diambil',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(height: 10, thickness: 2),
                        SizedBox(height: 8.0),
                        ...krsList.map((item) => _buildCourseItem(
                          item['mata_kuliah']?['nama'] ?? '-',
                          'Kode: ${item['mata_kuliah']?['kode'] ?? '-'} | SKS: ${item['mata_kuliah']?['sks'] ?? '-'} | Status: ${item['status'] ?? '-'}',
                          Icons.verified_user,
                        )),
                        SizedBox(height: 16.0),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detailkrs()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 45, 51, 87),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              textStyle: TextStyle(fontSize: 16),
                            ),
                            child: Text('Detail KRS'),
                          ),
                        ),
                      ],
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

  Widget _buildCourseItem(String courseName, String schedule, [IconData? icon]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon ?? Icons.check_circle, color: Colors.indigo),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(courseName, style: TextStyle(fontSize: 16)),
              Text(schedule, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
