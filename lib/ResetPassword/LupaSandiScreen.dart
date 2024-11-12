import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lupasandiscreen extends StatefulWidget {
  const Lupasandiscreen({super.key});

  @override
  State<Lupasandiscreen> createState() => _LupasandiscreenState();
}

class _LupasandiscreenState extends State<Lupasandiscreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> _checkPhoneNumber(BuildContext context) async {
  final phoneNumber = _phoneController.text;
  
  try {
    print("Memeriksa nomor telepon: $phoneNumber");

    final querySnapshot = await _firestore
        .collection('users')
        .where('phone', isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print("Nomor terdeteksi sebagai terdaftar.");
      
    } else {
      print("Nomor tidak terdaftar.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nomor tidak terdaftar!')),
      );
    }
  } catch (e) {
    print("Terjadi kesalahan: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Terjadi kesalahan: $e')),
    );
  }
}

Future<void> _sendResetCode(String phoneNumber, BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-verifikasi langsung dan login
        await _auth.signInWithCredential(credential);
        Navigator.of(context).pushNamed('/NewPass'); // Navigasi ke halaman reset password
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verifikasi gagal: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim kode: ${e.message}')),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        print("Kode verifikasi terkirim ke $phoneNumber.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kode verifikasi telah dikirim ke $phoneNumber')),
        );
        // Simpan verificationId untuk digunakan di halaman reset password
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Waktu habis untuk verifikasi otomatis.");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D3357),
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'LUPA PASSWORD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/form.png',
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      )),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Silahkan Masukan Nomor Anda',
                          style:
                              TextStyle(color: Color.fromARGB(255, 45, 51, 87)),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          labelText: 'No Hp',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mohon masukkan nomor HP';
                          }
                          if (value.length < 10) {
                            return 'Nomor HP tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Button to navigate to HomeScreen
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2D3357),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _checkPhoneNumber(context);
                            }
                          },
                          child: Text('LANJUTKAN',
                              style: TextStyle(color: Colors.white)),
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

