import 'package:academic_mobile/screen/homepage/HomeScreen.dart';
import 'package:academic_mobile/screen/welcomescreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  Future<bool> _checkTokenOrGoogle() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final user = FirebaseAuth.instance.currentUser;
    return (token != null && token.isNotEmpty) || user != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkTokenOrGoogle(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == true) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}