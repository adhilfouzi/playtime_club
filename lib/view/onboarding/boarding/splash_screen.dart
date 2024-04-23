import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/const/image_name.dart';
import '../../../view_model/Getx/usermodel_controller.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject repositories and controllers
    Get.put(UserController());
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
    );

    return Scaffold(
      backgroundColor: CustomColor.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo widget
            Image.asset(logo),

            // Circular progress indicator
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
