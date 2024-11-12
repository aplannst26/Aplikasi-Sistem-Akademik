import 'package:academic_mobile/screen/homepage/Biodata.dart';
import 'package:academic_mobile/screen/homepage/JadwalKuliahPage.dart';
import 'package:academic_mobile/screen/homepage/KRSPage.dart';
import 'package:academic_mobile/screen/homepage/profile.dart';
import 'package:academic_mobile/theme/color.dart';
import 'package:flutter/material.dart';
import './informasi.dart';
import './Activitas.dart';
import './DetailKHS.dart';
import './KTM.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages to navigate between
  final List<Widget> _pages = [HomePage(), KTMPage(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(45, 51, 87, 1),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'KTM',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'PROFIL',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Existing HomePage widget content
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          // Top Bar with Title
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Portal UCN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman selanjutnya
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Informasi()),
                  );
                },
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 20),

          // University image and details
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // University image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/univ.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),

                // University details
                Text(
                  'Universitas Cendikia Nusantara',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
                Text(
                  'Jl. Siliwangi (Ringroad Utara) Jombor Sleman  D.I Yogyakarta',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20),

                // Row for Aktivitas and Lihat Semua
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Activitas()),
                        );
                      },
                      child: Text(
                        'Aktivitas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Activitas()),
                        );
                      },
                      child: Text(
                        'Lihat Semua',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),

                // Icon Cards
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JadwalKuliahPage()),
                          );
                        },
                        child: IconCard(icon: Icons.schedule, label: 'Jadwal'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Biodata()),
                          );
                        },
                        child: IconCard(icon: Icons.person, label: 'Biodata'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Krspage()),
                          );
                        },
                        child: IconCard(icon: Icons.insert_chart, label: 'KRS'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailKHS()),
                          );
                        },
                        child: IconCard(icon: Icons.report, label: 'KHS'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Jadwal Kuliah
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jadwal Kuliah Hari Ini',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                    Icon(
                      Icons.arrow_circle_right_rounded,
                      color: AppColor.grey,
                      size: 40,
                      semanticLabel: 'Lihat jadwal',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Rabu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
                SizedBox(height: 10),

                // Jadwal Kuliah Card
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_downward, color: AppColor.primary),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '09:40 - 12:10',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rekayasa Web Praktik',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text('E.3.3'),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Informasi Untuk Kamu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Informasi()),
                        );
                      },
                      child: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: AppColor.grey,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 500,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      // First image and text item
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'assets/group16.png',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
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
                                color: Colors.indigo,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Sejak pandemi melanda negeri banyak UMKM mengalami kesulitan pemasukan.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 26, 126, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'assets/group17.png', // Replace with your second image path
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mahasiswa UTY bangun inovasi teknologi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo[900],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Teknologi berkembang pesat, dan mahasiswa UTY ikut berinovasi di bidang ini.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 26, 126, 31),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'assets/group18.png', // Replace with your second image path
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mahasiswa UTY bangun inovasi teknologi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo[900],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Teknologi berkembang pesat, dan mahasiswa UTY ikut berinovasi di bidang ini.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 26, 126, 28),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
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
        ],
      ),
    );
  }
}

// Widget for Icon Cards
class IconCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconCard({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColor.primary,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
