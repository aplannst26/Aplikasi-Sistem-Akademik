import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';

class Biodata extends StatelessWidget {
  const Biodata({super.key});

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
                    'Biodata', // Changed from KTM to KRS
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // BIODATA Section
                      const Text(
                        'BIODATA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 51, 87),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildLabel('Nama Lengkap'),
                      _buildTextField(),
                      const SizedBox(height: 16),

                      _buildLabel('Jenis Kelamin'),
                      _buildTextField(),
                      const SizedBox(height: 16),

                      _buildLabel('Tempat / Tanggal Lahir'),
                      _buildTextField(),
                      const SizedBox(height: 32),

                      // KEMAHASISWAAN Section
                      Divider(
                        height: 30,
                        thickness: 2,
                      ),
                      const Text(
                        'KEMAHASISWAAN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 51, 87),
                        ),
                      ),
                      Divider(
                        height: 30,
                        thickness: 2,
                      ),
                      const SizedBox(height: 16),

                      _buildLabel('Nama Lengkap'),
                      _buildTextField(),
                      const SizedBox(height: 16),

                      _buildLabel('Jenis Kelamin'),
                      _buildTextField(),
                      const SizedBox(height: 16),

                      _buildLabel('Tempat / Tanggal Lahir'),
                      _buildTextField(),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 89, 96, 139),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
