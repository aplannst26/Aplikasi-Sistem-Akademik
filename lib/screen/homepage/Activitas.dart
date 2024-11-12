import 'package:academic_mobile/screen/homepage/Biodata.dart';
import 'package:academic_mobile/screen/homepage/DetailKHS.dart';
import 'package:academic_mobile/screen/homepage/DetailKRS.dart';
import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:academic_mobile/screen/homepage/JadwalKuliahPage.dart';
import 'package:academic_mobile/screen/homepage/KRSPage.dart';
import 'package:academic_mobile/screen/homepage/TambahMK.dart';
import 'package:academic_mobile/screen/homepage/pengajuancuti.dart';
import 'package:flutter/material.dart';

class Activitas extends StatelessWidget {
  const Activitas({super.key});

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
                  const Expanded(
                    child: Center(
                      child: Text(
                        'KRS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
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
                child: GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 3, // Changed to 3 to match the image layout
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JadwalKuliahPage()),
                        );
                      },
                    child: createGridItem(Icons.bookmark, 'Jadwal'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Biodata()),
                        );
                      },
                   child: createGridItem(Icons.account_box, 'Biodata'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Krspage()),
                        );
                      },
                    child: createGridItem(Icons.analytics, 'KRS'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailKHS()),
                        );
                      },
                    child: createGridItem(Icons.assignment, 'KHS'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TambahMKPage()),
                        );
                      },
                      child: createGridItem(Icons.add, 'Tambah MK'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Detailkrs()),
                        );
                      },
                      child: createGridItem(Icons.details, 'Detail KRS'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PengajuanCutiPage()),
                        );
                      },
                      child:
                          createGridItem(Icons.beach_access, 'Pengajuan Cuti'),
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

  Widget createGridItem(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon,
              size: 40, color: Colors.white), // Adjusted icon size and color
          const SizedBox(height: 10), // Added spacing between icon and text
          Text(
            title,
            style:
                TextStyle(color: Colors.white), // Text color changed to white
            textAlign: TextAlign.center, // Centered the text
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(
            255, 45, 51, 87), // Set background color similar to the design
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
