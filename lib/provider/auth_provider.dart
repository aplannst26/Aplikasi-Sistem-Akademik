import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

final _fireAuth = FirebaseAuth.instance;

class AuthProvider extends ChangeNotifier {
  final form = GlobalKey<FormState>();

  var isLogin = true;
  var enteredEmail = '';
  var enteredPassword = '';

  void submit() async {
    final isValid = form.currentState!.validate();

    if (!isValid) {
      return;
    }

    form.currentState!.save();

    try {
      if (isLogin) {
        final userCredential = await _fireAuth.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        log("User signed in: ${userCredential.user?.uid}");
      } else {
        final userCredential = await _fireAuth.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        log("User registered: ${userCredential.user?.uid}");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log("Email sudah digunakan.");
      } else if (e.code == 'user-not-found') {
        log("Pengguna tidak ditemukan.");
      } else if (e.code == 'wrong-password') {
        log("Password salah.");
      } else {
        log("Terjadi error: ${e.message}");
      }
    } catch (e) {
      log("Error tidak terduga: $e");
    }

    notifyListeners();
  }
}
