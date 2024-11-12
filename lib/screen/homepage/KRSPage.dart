import 'package:academic_mobile/screen/homepage/DetailKRS.dart';
import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';

class Krspage extends StatelessWidget {
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
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                  ),
                  const Text(
                    'KRS', // Changed from KTM to KRS
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
                child: SingleChildScrollView( // Changed from ListView to SingleChildScrollView
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kartu Rencana Studi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 51, 87),
                        ),
                      ),
                      Divider(height: 30, thickness: 2,),
                      const SizedBox(height: 16),
                      
                      // KRS Information
                      _buildKRSItem('Kartu Rencana Studi', '4 MK', Icons.description),
                      Divider(height: 10, thickness: 2),
                      _buildKRSItem('Jumlah SKS', '9 SKS', Icons.layers),
                      Divider(height: 10, thickness: 2),
                      _buildKRSItem('Tahun Ajaran', '2023/2024', Icons.calendar_today),
                      Divider(height: 10, thickness: 2),
                      _buildKRSItem('Semester', 'Ganjil', Icons.donut_small),
                      Divider(height: 10, thickness: 2),

                      SizedBox(height: 16.0),
                      Text(
                        'Daftar Mata Kuliah yang Diambil',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(height: 10, thickness: 2),
                      SizedBox(height: 8.0),
                      
                      // Course List
                      _buildCourseItem('Data Mining', 'Senin, 07:00 - 09:10 WIB', Icons.verified_user),
                      _buildCourseItem('Sistem Operasi', 'Selasa, 09:00 - 12:10 WIB', Icons.verified_user),
                      _buildCourseItem('Mobile Computing', 'Selasa, 14:20 - 15:40 WIB', Icons.verified_user),
                      _buildCourseItem('Rekayasa Web', 'Selasa, 09:00 - 12:10 WIB', Icons.verified_user),

                      // Detail Button
                      SizedBox(height: 16.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Detailkrs()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 45, 51, 87),
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            textStyle: TextStyle(fontSize: 16),
                          ),
                          child: Text('Detail KRS'),
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

   Widget _buildKRSItem(String title, String value, [IconData? icon]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon),
                SizedBox(width: 8),
              ],
              Text(title),
            ],
          ),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
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
          // ... rest of the method remains the same ...
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
