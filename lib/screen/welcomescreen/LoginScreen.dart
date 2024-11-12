import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:academic_mobile/screen/welcomescreen/RegisterScreen.dart';
import '../../ResetPassword/LupaSandiScreen.dart';
import 'package:academic_mobile/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form key untuk validasi
  final _formKey = GlobalKey<FormState>();
  
  // Controller untuk text fields
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Firebase Auth instance
  final _auth = FirebaseAuth.instance;
  
  // Loading state
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SISTEM INFORMASI AKADEMIK',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary
                ),
              ),
              const Text(
                'UNIVERSITAS CENDIKIA NUSANTARA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColor.primary
                ),
              ),
              const SizedBox(height: 5),
              const Image(
                image: AssetImage('assets/form.png'),
                width: 350,
                height: 350
              ),
              const SizedBox(height: 2),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 45, 51, 87)
                ),
              ),
              const SizedBox(height: 20),
              // NIM field dengan validasi
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Nomor Induk Mahasiswa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan NIM';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Password field dengan validasi
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const Lupasandiscreen()),
                    );
                  },
                  child: const Text(
                    'Lupa Password?',
                    style: TextStyle(
                      color: AppColor.primary
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => _handleLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Belum Punya Akun?',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColor.primary
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Mencoba login dengan Firebase
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: "${_nimController.text}@student.ucn.ac.id", // Menggunakan NIM sebagai email
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Login berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Akun tidak ditemukan. Silakan daftar terlebih dahulu.';
      } else if (e.code == 'wrong-password') {
        message = 'Password salah. Silakan coba lagi.';
      } else {
        message = 'Akun Tidak Terdaftar Silahkan Daftar Terlebih Dahulu:';
      }
      
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nimController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}