import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:academic_mobile/screen/homepage/Mahasiswa.dart';
import 'package:flutter/material.dart';

class Informasi extends StatelessWidget {
  const Informasi({super.key});

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
                    'Informasi', // Changed from KTM to KRS
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
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      // Card pertama
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/group16.png',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                                height: 10), // Menambahkan jarak antar elemen
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mahasiswa UTY bangun startup',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo[900],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Sejak pandemi melanda negeri banyak UMKM mengalami kesulitan pemasukan.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo[900],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Mahasiswa()),
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Selanjutnya'),
                                        SizedBox(width: 8),
                                        Icon(Icons.arrow_right_alt),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16), // Jarak antar card

                      // Card kedua
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/group17.png',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                                height: 10), // Menambahkan jarak antar elemen
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mahasiswa UTY bangun startup',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo[900],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Sejak pandemi melanda negeri banyak UMKM mengalami kesulitan pemasukan.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo[900],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Mahasiswa()),
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Selanjutnya'),
                                        SizedBox(width: 8),
                                        Icon(Icons.arrow_right_alt),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16), // Jarak antar card

                      // Card ketiga
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/group18.png',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                                height: 10), // Menambahkan jarak antar elemen
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mahasiswa UTY bangun startup',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 45, 51, 87),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Sejak pandemi melanda negeri banyak UMKM mengalami kesulitan pemasukan.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 45, 51, 87),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Mahasiswa()),
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Selanjutnya'),
                                        SizedBox(width: 8),
                                        Icon(Icons.arrow_right_alt),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
}
