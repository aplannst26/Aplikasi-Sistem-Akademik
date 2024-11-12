import 'dart:async';

import 'package:academic_mobile/screen/splash/SplashScreen2.dart';
import 'package:academic_mobile/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Spalsh extends StatelessWidget {
  const Spalsh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), (){
      Get.to(() => Spalsh2());

    });
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/splash1.png'),
              width: 400,
              ),
          ],
        ),
      ),
    );
  }
}