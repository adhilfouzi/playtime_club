import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/utils/portion/snackbar.dart';

import '../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../utils/portion/loadingpopup.dart';
import '../../view/course/bottom_navigationbar_widget.dart';

class SigninController extends GetxController {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  void signin() async {
    try {
      if (!loginKey.currentState!.validate()) return;

      var email = emailTextEditingController.text;
      var password = passwordTextEditingController.text;

      Get.to(() => const LoadingPopup()); // Using Get.to to navigate
      bool user = await AuthenticationRepository()
          .signInWithEmailAndPassword(email, password);

      if (user) {
        Get.offAll(() => const MyBottomNavigationBar());
      } else {
        // Handle error
        log("Some error happened");
      }
    } catch (e) {
      // Handle error
      Get.back();
      log(e.toString());
      CustomSnackbar.showError(e.toString());
    } finally {}
  }
}
