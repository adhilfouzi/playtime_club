import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view/onboarding/signup/a02/a02_signup_screen.dart';
import '../usermodel_controller.dart';

class A01SignupController extends GetxController {
  final TextEditingController courtNameController = TextEditingController();
  final TextEditingController courtPhoneNumberController =
      TextEditingController();
  final TextEditingController courtEmailAddressController =
      TextEditingController();

  final RxString courtName = ''.obs;
  final RxString courtPhoneNumber = ''.obs;
  final RxString courtEmailAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final userController = Get.find<UserController>();
    userController.getUserRecord();
    ever(userController.courtName, (value) {
      courtName.value = value;
      courtNameController.text = value;
    });
    ever(userController.courtPhoneNumber, (value) {
      courtPhoneNumber.value = value;
      courtPhoneNumberController.text = value;
    });
    ever(userController.courtEmailAddress, (value) {
      courtEmailAddress.value = value;
      courtEmailAddressController.text = value;
    });
  }

  void submit() async {
    final String courtName = courtNameController.text;
    final String courtPhoneNumber = courtPhoneNumberController.text;
    final String courtEmailAddress = courtEmailAddressController.text;

    // Create a new UserController instance (optional, if not using GetX dependency injection)
    final userController = UserController();

    // Update UserController's values with signup data
    log("submit $courtName");

    userController.updateValues(
      courtName: courtName,
      courtPhoneNumber: courtPhoneNumber,
      courtEmailAddress: courtEmailAddress,
    );
    // await userController.updataUser();

    // Navigate to the next screen, potentially passing userController as an argument
    Get.to(A02SignupScreen());
  }

  @override
  void dispose() {
    courtNameController.dispose();
    courtPhoneNumberController.dispose();
    courtEmailAddressController.dispose();
    super.dispose();
  }
}
