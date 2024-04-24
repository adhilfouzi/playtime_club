import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/portion/snackbar.dart';
import '../../../view/onboarding/signup/a03/a03_signup_screen.dart';
import '../usermodel_controller.dart';

class A02SignupController extends GetxController {
  static A02SignupController get instance => Get.find();

  final TextEditingController descriptionController = TextEditingController();
  TimeOfDay? openingTimeFetch;
  TimeOfDay? closingTimeFetch;

  UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    descriptionController.text = userController.user.value.courtDescription;
    // Convert string to TimeOfDay
    openingTimeFetch =
        convertToTimeOfDay(userController.user.value.openingTime);
    closingTimeFetch =
        convertToTimeOfDay(userController.user.value.closingTime);
  }

  TimeOfDay convertToTimeOfDay(String timeString) {
    try {
      List<String> parts = timeString.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    } catch (e) {
      return TimeOfDay.now();
    }
  }

  String convertTimeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  void submit() {
    if (openingTimeFetch == null && closingTimeFetch == null) {
      CustomSnackbar.showError('Please fill in all required fields.');
      return;
    }
    userController.user.value.courtDescription = descriptionController.text;
    userController.user.value.openingTime =
        convertTimeOfDayToString(openingTimeFetch!);
    userController.user.value.closingTime =
        convertTimeOfDayToString(closingTimeFetch!);
    Get.to(A03SignupScreen());
    log(userController.user.value.closingTime);
    log(userController.user.value.openingTime);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}
