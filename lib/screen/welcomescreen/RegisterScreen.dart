import 'package:academic_mobile/screen/welcomescreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:academic_mobile/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:academic_mobile/service/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk form fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fakultasController = TextEditingController();
  final TextEditingController _prodiController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _tahunMasukController = TextEditingController();

  // ApiService instance
  final ApiService apiService = ApiService();
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
                  color: AppColor.primary,
                ),
              ),
              const Text(
                'UNIVERSITAS CENDIKIA NUSANTARA',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: AppColor.primary),
              ),
              const SizedBox(height: 20),
              const Image(
                image: AssetImage('assets/form.png'),
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 15),
              const Text(
                'Registrasi',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(height: 20),
              // Email field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Email Mahasiswa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Email';
                  }
                  if (value.length < 8) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // NIM field
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Nim',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Nim';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Nama field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Nama';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // No Hp field
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
              // Program Studi field
              TextFormField(
                controller: _prodiController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.school),
                  labelText: 'Program Studi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Program Studi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Fakultas field
              TextFormField(
                controller: _fakultasController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.account_balance),
                  labelText: 'Fakultas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Fakultas';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Semester field
              TextFormField(
                controller: _semesterController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.calendar_today),
                  labelText: 'Semester',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Semester';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Tahun Masuk field
              TextFormField(
                controller: _tahunMasukController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.date_range),
                  labelText: 'Tahun Masuk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Tahun Masuk';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Password field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan password';
                  }
                  if (value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Konfirmasi Password field
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Konfirmasi Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon konfirmasi password';
                  }
                  if (value != _passwordController.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              // Button Daftar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => _handleRegister(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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

  Future<void> _handleRegister(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await apiService.registerUser(
  username: _nameController.text, // username diisi dari nama
  email: _emailController.text,
  nim: _nimController.text,
  name: _nameController.text,
  phone: _phoneController.text,
  password: _passwordController.text,
  fakultas: _fakultasController.text,
  programStudi: _prodiController.text,
  semester: _semesterController.text,
  tahunMasuk: _tahunMasukController.text,
);

      if (result['success'] == true || result['access_token'] != null) {
        Fluttertoast.showToast(
          msg: result['message'] ?? 'Registrasi berhasil! Silakan login.',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
        );
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: result['message'] ?? 'Registrasi gagal',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      String errorMsg = 'Registrasi gagal. ';
      try {
        final errorStr = e.toString();
        if (errorStr.contains('email has already been taken')) {
          errorMsg = 'Email sudah terdaftar';
        } else if (errorStr.contains('nim has already been taken')) {
          errorMsg = 'NIM sudah terdaftar';
        } else if (errorStr.contains('username has already been taken')) {
          errorMsg = 'Username sudah terdaftar';
        } else {
          errorMsg = e.toString();
        }
      } catch (_) {
        errorMsg = e.toString();
      }
      Fluttertoast.showToast(
        msg: errorMsg,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      if (mounted) setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nimController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fakultasController.dispose();
    _prodiController.dispose();
    _semesterController.dispose();
    _tahunMasukController.dispose();
    super.dispose();
  }
}
