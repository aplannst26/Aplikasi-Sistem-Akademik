import 'package:academic_mobile/screen/homepage/Biodata.dart';
import 'package:academic_mobile/screen/homepage/DetailKHS.dart';
import 'package:academic_mobile/screen/homepage/DetailKRS.dart';
import 'package:academic_mobile/screen/homepage/JadwalKuliahPage.dart';
import 'package:academic_mobile/screen/homepage/KRSPage.dart';
import 'package:academic_mobile/screen/homepage/TambahMK.dart';
import 'package:academic_mobile/screen/homepage/pengajuancuti.dart';
import 'package:academic_mobile/screen/homepage/pengumuman.dart';
import 'package:academic_mobile/screen/homepage/uploadtugas.dart';
import 'package:flutter/material.dart';
import 'package:academic_mobile/service/api_service.dart';
import 'package:academic_mobile/screen/homepage/absensi.dart';
import 'package:flutter/services.dart'; // Added for SharedPreferences
import 'dart:convert'; // Added for jsonDecode
import 'package:http/http.dart' as http; // Added for http

class Activitas extends StatelessWidget {
  const Activitas({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    final String baseUrl = 'https://your-api-url.com/api'; // Ganti dengan baseUrl Anda
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 51, 87),
        title: Text('Aktivitas', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 3, // Changed to 3 to match the image layout
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JadwalKuliahPage()),
              );
            },
            child: createGridItem(Icons.schedule, 'Jadwal'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Biodata()),
              );
            },
            child: createGridItem(Icons.account_box, 'Biodata'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Krspage()),
              );
            },
            child: createGridItem(Icons.book, 'KRS'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailKHS()),
              );
            },
            child: createGridItem(Icons.bookmark, 'KHS'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TambahMKPage()),
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
                MaterialPageRoute(builder: (context) => PengajuanCutiPage()),
              );
            },
            child: createGridItem(Icons.beach_access, 'Pengajuan Cuti'),
          ),
          GestureDetector(
            onTap: () async {
              try {
                final krsList = await apiService.getKRS();
                print('KRS List: ' + krsList.toString());
                if (krsList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Anda belum mengambil mata kuliah. Silakan ambil KRS terlebih dahulu.')),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AbsensiPage(krsList: krsList),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal mengambil data KRS')));
              }
            },
            child: createGridItem(Icons.how_to_reg, 'Absensi'),
          ),
          GestureDetector(
            onTap: () async {
              try {
                final krsList = await apiService.getKRS();
                print('KRS List: ' + krsList.toString());
                if (krsList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Anda belum mengambil mata kuliah. Silakan ambil KRS terlebih dahulu.')),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadTugasPage(krsList: krsList, baseUrl: baseUrl),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal mengambil data KRS')));
              }
            },
            child: createGridItem(Icons.upload_file, 'Upload Tugas'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PengumumanPage()),
              );
            },
            child: createGridItem(Icons.announcement, 'Pengumuman'),
          )
        ],
      ),
    );
  }

  Widget createGridItem(IconData icon, String title) {
  print("Creating grid item: $title");  // Debug print
  return Container(
    padding: const EdgeInsets.all(5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 40, color: Colors.white),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 45, 51, 87),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

}
