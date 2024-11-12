import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:academic_mobile/theme/color.dart';

class JadwalKuliahPage extends StatelessWidget {
  const JadwalKuliahPage({Key? key}) : super(key: key);

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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleDateWidget(date: '27'),
                            const SizedBox(width: 8),
                            const Text(
                              'Rabu',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        JadwalCard(
                          time: '09:40 - 12:10',
                          course: 'Rekayasa Web Praktik',
                          room: 'E.3.3',
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 20),
                        const Text(
                          'Jadwal kuliah saya',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const Text(
                              'Senin',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        JadwalCard(
                          time: '07:00 - 09:10',
                          course: 'Testing & Implementasi',
                          room: 'H.2.3',
                        ),
                        Row(
                          children: [
                            const Text(
                              'Selasa',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        JadwalCard(
                          time: '09:40 - 12:10',
                          course: 'Sistem Operasi',
                          room: 'G.2.2',
                        ),
                        const SizedBox(height: 10),
                        JadwalCard(
                          time: '14:20 - 15:00',
                          course: 'Mobile Computing',
                          room: 'G.3.2',
                        ),
                        Row(
                          children: [
                            const Text(
                              'Rabu',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        JadwalCard(
                          time: '09:40 - 12:10',
                          course: 'Rekayasa Web Praktik',
                          room: 'E.3.3',
                          ),
                      ],
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

  const JadwalCard({
    Key? key,
    required this.time,
    required this.course,
    required this.room,
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
          Icon(Icons.arrow_downward, color: AppColor.primary),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
