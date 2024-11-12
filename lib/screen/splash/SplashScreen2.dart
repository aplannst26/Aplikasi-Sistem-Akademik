import 'dart:async';

import 'package:academic_mobile/screen/welcomescreen/WelcomeScreen.dart';
import 'package:academic_mobile/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Spalsh2 extends StatelessWidget {
  const Spalsh2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
    Get.to(() => WelcomeScreen());
  });
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/splash.png'),
              width: 400,
              ),
          ],
        ),
      ),
    );
  }
}