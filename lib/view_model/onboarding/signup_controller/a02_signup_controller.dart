import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/portion/snackbar.dart';
import '../../../view/onboarding/signup/screen/a03/a03_signup_screen.dart';
import '../../course/usermodel_controller.dart';

class A02SignupController extends GetxController {
  static A02SignupController get instance => Get.find();

  final descriptionController = TextEditingController();
  final locationfindTextEditingController = TextEditingController();
  TimeOfDay? openingTimeFetch;
  TimeOfDay? closingTimeFetch;
  var isOpen24Hours = false.obs;

  UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    descriptionController.text = userController.user.value.courtDescription;
    locationfindTextEditingController.text =
        userController.user.value.courtLocation;
    isOpen24Hours.value = userController.user.value.is24h;
    // Convert string to TimeOfDay
    openingTimeFetch = userController.user.value.openingTime;
    closingTimeFetch = userController.user.value.closingTime;
  }

  String convertTimeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  void submit() async {
    if (openingTimeFetch == null && closingTimeFetch == null) {
      CustomSnackbar.showError('Please fill in all required fields.');
      return;
    }
    userController.user.value.courtDescription = descriptionController.text;
    userController.user.value.openingTime = openingTimeFetch!;
    userController.user.value.closingTime = closingTimeFetch!;
    userController.user.value.is24h = isOpen24Hours.value;
    Get.to(A03SignupScreen());
    log(userController.user.value.closingTime.toString());
    log(userController.user.value.openingTime.toString());
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}
