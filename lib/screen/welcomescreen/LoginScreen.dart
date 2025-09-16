import 'package:academic_mobile/ResetPassword/ResetPassword.dart';
import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:academic_mobile/screen/welcomescreen/RegisterScreen.dart';
import 'package:academic_mobile/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:academic_mobile/service/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService apiService = ApiService();
  String? googleName;

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Kirim ke backend untuk dapatkan access_token backend
      final response = await http.post(
        Uri.parse('${apiService.baseUrl}/login-google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': googleUser.email,
          'nama_lengkap': googleUser.displayName,
        }),
      );
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', data['access_token']);

      setState(() {
        googleName = googleUser.displayName;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(googleName: googleName),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Login Google gagal: $e',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

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
              // Username field (ganti dari email)
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan Username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Password field with validation
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
                      MaterialPageRoute(builder: (context) => const ResetPassword()),
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
                  onPressed: () => _handleLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  icon: Image.asset('assets/google.png', width: 24, height: 24),
                  label: const Text('Login dengan Google', style: TextStyle(color: AppColor.primary)),
                  onPressed: () => _handleGoogleSignIn(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColor.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap:() {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child:  Text(
                  'Belum Punya Akun?',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.primary
                  ),
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
    if (!_formKey.currentState!.validate()) return;
    try {
      final result = await apiService.loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (result['access_token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', result['access_token']);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Fluttertoast.showToast(
          msg: result['message'] ?? 'Login gagal',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
