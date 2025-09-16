import 'package:academic_mobile/screen/welcomescreen/LoginScreen.dart';
import 'package:academic_mobile/screen/welcomescreen/MainPage.dart';
import 'package:academic_mobile/theme/color.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SELAMAT DATANG \n DI PORTAL AKADEMIK',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: AppColor.primary
              ),
            ),
            SizedBox(height: 30),
            const Image(
              image: AssetImage('assets/welcome.png'),
              width: 500,
              height: 500, 
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => Mainpage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'LANJUTKAN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
              )
          ],
        ),
      ),
    );
  }
}