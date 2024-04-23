import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view/onboarding/signup/a02/a02_signup_screen.dart';

class A01SignupController extends GetxController {
  static A01SignupController get instance => Get.find();

  final TextEditingController courtNameController = TextEditingController();
  final TextEditingController courtPhoneNumberController =
      TextEditingController();
  final TextEditingController courtEmailAddressController =
      TextEditingController();

  void submit() {
    // You can perform any validation or logic here
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
