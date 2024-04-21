import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view/onboarding/signup/a02_signup_screen.dart';

import '../../utils/portion/snackbar.dart';
import '../../view/course/bottom_navigationbar_widget.dart';
import '../../view/onboarding/signup/a03_signup_screen.dart';
import '../../view/onboarding/signup/a04_signup_screen.dart';

class BusinessRegistration extends GetxController {
  //TextEditingController
  final courtNameTextEditingController = TextEditingController();
  final courtPhoneNumberTextEditingController = TextEditingController();
  final courtEmailAddressTextEditingController = TextEditingController();
  final TextEditingController descriptionAboutTurfTextEditingController =
      TextEditingController();
  final fullNameTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();

  //GlobalKey
  final GlobalKey<FormState> a40FormKey = GlobalKey<FormState>();

  TimeOfDay? openingTimeFetch;
  TimeOfDay? closingTimeFetch;
  String? courtLocation = '';
  var privacyPolicyChecked = false.obs;

  void a01Submit() {
    Get.to(A02SignupScreen());
  }

  void a02Submit() {
    if (openingTimeFetch == null && closingTimeFetch == null) {
      CustomSnackbar.showError('Please fill in all required fields.');
      return;
    }

    Get.to(A03SignupScreen());
  }

  void a03Submit() {
    Get.to(A04SignupScreen());
  }

  void a04Submit() {
    if (!a40FormKey.currentState!.validate()) return;
    if (!privacyPolicyChecked.value) {
      CustomSnackbar.showError("need to acept the privacy &Policy");
      return;
    }
    Get.offAll(const MyBottomNavigationBar());
  }

  @override
  void dispose() {
    courtNameTextEditingController.dispose();
    courtPhoneNumberTextEditingController.dispose();
    courtEmailAddressTextEditingController.dispose();
    descriptionAboutTurfTextEditingController.dispose();
    fullNameTextEditingController.dispose();
    phoneNumberTextEditingController.dispose();
    emailTextEditingController.dispose();
    super.dispose();
  }
}
