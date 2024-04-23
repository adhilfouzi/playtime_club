import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/portion/snackbar.dart';
import '../../../view/onboarding/signup/a03/a03_signup_screen.dart';
import '../usermodel_controller.dart';

class A02SignupController extends GetxController {
  final TextEditingController descriptionAboutTurfTextEditingController =
      TextEditingController();
  TimeOfDay? openingTimeFetch;
  TimeOfDay? closingTimeFetch;

  @override
  void onInit() {
    super.onInit();
    final userController = Get.find<UserController>();
    descriptionAboutTurfTextEditingController.text =
        userController.courtDescription.value;
  }

  void setOpeningAndClosingTime(TimeOfDay openingTime, TimeOfDay closingTime) {
    openingTimeFetch = openingTime;
    closingTimeFetch = closingTime;
  }

  void submit() async {
    if (openingTimeFetch == null && closingTimeFetch == null) {
      CustomSnackbar.showError('Please fill in all required fields.');
      return;
    }

    final userController = UserController();

    // Update UserController's values with signup data
    log("submit $openingTimeFetch.toString()");

    userController.updateValues(
      courtDescription: descriptionAboutTurfTextEditingController.text,
      openingTime: openingTimeFetch,
      closingTime: closingTimeFetch,
    );
    // await userController.updataUser();

    Get.to(A03SignupScreen());
  }

  @override
  void dispose() {
    descriptionAboutTurfTextEditingController.dispose();
    super.dispose();
  }
}
