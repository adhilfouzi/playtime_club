import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../../model/backend/repositories/user/user_repositories.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/const/image_name.dart';
import '../../../view_model/course/slot_request_controller.dart';
import '../../../view_model/course/transaction_controller.dart';
import '../../../view_model/course/usermodel_controller.dart';
import '../../../view_model/onboarding/signup/image_controller.dart';
import '../../../view_model/onboarding/signup/signup_controller.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(UserRepository());
    Get.put(UserController());
    Get.put(SlotReservationController(), permanent: true);
    Get.put(TransactionController(), permanent: true);
    Get.put(SignupController());

    checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ImageController());
    var height = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      backgroundColor: CustomColor.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height),
            Image.asset(ImagePath.logo),
            SizedBox(height: height),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> checkUserLoggedIn() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    log("checkUserLoggedIn");
    if (user == null) {
      log("LoginScreen");
      await Future.delayed(const Duration(seconds: 2));
      Get.off(() => LoginScreen());
    } else {
      log("signInWithEmailAndPassword");
      await AuthenticationRepository()
          .signInWithEmailAndPassword('email', 'password', true);
    }
  } catch (e) {
    log('Error querying the database: $e');
  }
}
