import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/portion/snackbar.dart';
import '../../../view/onboarding/signup/a03/a03_signup_screen.dart';

class A02SignupController extends GetxController {
  final TextEditingController descriptionAboutTurfTextEditingController =
      TextEditingController();
  TimeOfDay? openingTimeFetch;
  TimeOfDay? closingTimeFetch;

  void setOpeningAndClosingTime(TimeOfDay openingTime, TimeOfDay closingTime) {
    openingTimeFetch = openingTime;
    closingTimeFetch = closingTime;
  }

  void submit() {
    if (openingTimeFetch == null && closingTimeFetch == null) {
      CustomSnackbar.showError('Please fill in all required fields.');
      return;
    }
    Get.to(A03SignupScreen());
  }

  @override
  void dispose() {
    descriptionAboutTurfTextEditingController.dispose();
    super.dispose();
  }
}
