import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  static const String id = 'reset_password';

  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  Future<void> _showMessage(String message) async {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content:
              const Text('Link reset password telah dikirim ke email Anda.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> resetPasswordWithFirestore() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim();

      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        _showMessage('Email tidak terdaftar dalam sistem');
        return;
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await _showConfirmationDialog();

      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Format email tidak valid';
          break;
        case 'user-not-found':
          errorMessage = 'Email tidak terdaftar';
          break;
        case 'too-many-requests':
          errorMessage = 'Terlalu banyak permintaan. Silakan coba lagi nanti';
          break;
        default:
          errorMessage = 'Terjadi kesalahan. Silakan coba lagi';
      }
      _showMessage(errorMessage);
    } catch (e) {
      _showMessage('Terjadi kesalahan yang tidak terduga');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 51, 87),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
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
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 5),
                          const Image(
                              image: AssetImage('assets/form.png'),
                              width: 350,
                              height: 250),
                          const SizedBox(height: 30),
                          const Text(
                            "Harap Diisi Dengan Benar",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _emailController,
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed:
                                _isLoading ? null : resetPasswordWithFirestore,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 45, 51, 87),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Kirim Link Reset',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
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
