import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:academic_mobile/theme/color.dart';
import 'package:academic_mobile/model/jadwal_kuliah.dart';
import 'package:academic_mobile/service/api_service.dart';

class JadwalKuliahPage extends StatefulWidget {
  const JadwalKuliahPage({Key? key}) : super(key: key);

  @override
  State<JadwalKuliahPage> createState() => _JadwalKuliahPageState();
}

class _JadwalKuliahPageState extends State<JadwalKuliahPage> {
  late Future<List<JadwalKuliah>> _futureJadwal;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureJadwal = apiService.getJadwalKuliah();
  }

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
                    'Jadwal Kuliah',
                    textAlign: TextAlign.center,
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: FutureBuilder<List<JadwalKuliah>>(
                  future: _futureJadwal,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Gagal memuat jadwal kuliah'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Tidak ada jadwal kuliah'));
                    }
                    final jadwalList = snapshot.data!;
                    return ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: jadwalList.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final jadwal = jadwalList[index];
                        return JadwalCard(
                          time: '${jadwal.jamMulai} - ${jadwal.jamSelesai}',
                          course: 'Mata Kuliah ID: ${jadwal.mataKuliahId}', // Ganti dengan nama MK jika ada relasi
                          room: jadwal.ruang,
                          hari: jadwal.hari,
                        );
                      },
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
}

// Widget khusus untuk menampilkan tanggal dalam lingkaran
class CircleDateWidget extends StatelessWidget {
  final String date;

  const CircleDateWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30, // Ukuran lingkaran
      height: 30,
      decoration: BoxDecoration(
        color: AppColor.primary, // Warna lingkaran
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          date,
          style: const TextStyle(
            color: Colors.white, // Warna teks
            fontSize: 15, // Ukuran teks
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class JadwalCard extends StatelessWidget {
  final String time;
  final String course;
  final String room;
  final String hari;

  const JadwalCard({
    Key? key,
    required this.time,
    required this.course,
    required this.room,
    required this.hari,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: AppColor.primary),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hari,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.primary),
              ),
              Text(
                time,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                course,
                style: const TextStyle(color: Colors.grey),
              ),
              Text(room),
            ],
          ),
        ],
      ),
    );
  }
}
