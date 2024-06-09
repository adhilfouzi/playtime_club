import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../../utils/portion/loadingpopup.dart';
import '../../../utils/portion/snackbar.dart';

class SigninController extends GetxController {
  static SigninController get instance => Get.find();

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

      Get.to(() => const LoadingPopup());
      var isError = await AuthenticationRepository()
          .signInWithEmailAndPassword(email, password, false);
      if (!isError) {
        Get.back();
        CustomSnackbar.showError(
            "Your account has some issue. Please contact support for assistance.");
      }
    } catch (e) {
      // Handle error
      Get.back();
      log(e.toString());
      CustomSnackbar.showError(e.toString());
    } finally {}
  }
}
