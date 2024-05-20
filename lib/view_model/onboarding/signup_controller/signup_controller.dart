import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/backend/repositories/user/user_repositories.dart';
import '../../../utils/portion/snackbar.dart';
import '../../../view/course/bottom_navigationbar_widget.dart';
import '../../../view/onboarding/signup/screen/a02/a02_signup_screen.dart';
import '../../../view/onboarding/signup/screen/a03/a03_signup_screen.dart';
import '../../../view/onboarding/signup/screen/a04/a04_signup_screen.dart';
import '../../course/usermodel_controller.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // A01 Fields
  final courtName = TextEditingController();
  final courtPhoneNumber = TextEditingController();
  final courtEmailAddress = TextEditingController();

  // A02 Fields
  final description = TextEditingController();
  final location = TextEditingController();
  final courtPrice = TextEditingController();
  TimeOfDay? openingTimeFetch;
  TimeOfDay? closingTimeFetch;
  var isOpen24Hours = false.obs;

  // A04 Fields
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var privacyPolicyChecked = false.obs;

  final UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();

    // Initialize A01 fields
    courtName.text = userController.user.value.courtName;
    courtPhoneNumber.text = userController.user.value.courtPhoneNumber;
    courtEmailAddress.text = userController.user.value.courtEmailAddress;

    // Initialize A02 fields
    description.text = userController.user.value.courtDescription;
    location.text = userController.user.value.courtLocation;
    isOpen24Hours.value = userController.user.value.is24h;
    courtPrice.text = userController.user.value.price.toString();
    openingTimeFetch = userController.user.value.openingTime;
    closingTimeFetch = userController.user.value.closingTime;

    // Initialize A04 fields
    privacyPolicyChecked.value = userController.user.value.isRegistered;
    fullName.text = userController.user.value.ownerFullName;
    phoneNumber.text = userController.user.value.ownerPhoneNumber;
    email.text = userController.user.value.ownerEmailAddress;
  }

  // A01 Methods
  void submitA01() {
    userController.user.value.courtName = courtName.text;
    userController.user.value.courtPhoneNumber = courtPhoneNumber.text;
    userController.user.value.courtEmailAddress = courtEmailAddress.text.trim();
    Get.to(A02SignupScreen());
    log(userController.user.value.courtPhoneNumber);
  }

  // A02 Methods
  String convertTimeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  void submitA02() async {
    if (openingTimeFetch == null && closingTimeFetch == null) {
      CustomSnackbar.showError('Please fill in all required fields.');
      return;
    }
    userController.user.value.courtDescription = description.text;
    userController.user.value.openingTime = openingTimeFetch!;
    userController.user.value.closingTime = closingTimeFetch!;
    userController.user.value.is24h = isOpen24Hours.value;
    userController.user.value.price = double.parse(courtPrice.text);

    Get.to(A03SignupScreen());
    log(userController.user.value.closingTime.toString());
    log(userController.user.value.openingTime.toString());
  }

  // A03 Methods
  void submitA03() {
    if (userController.user.value.images.length < 3) {
      CustomSnackbar.showError("Add at least 3 images of your Business");
    } else {
      Get.to(A04SignupScreen());
    }
  }

  // A04 Methods
  void submitA04() async {
    if (formKey.currentState!.validate()) {
      if (!privacyPolicyChecked.value) {
        CustomSnackbar.showError("Need to accept the privacy & policy");
        return;
      }
      userController.user.value.ownerFullName = fullName.text;
      userController.user.value.ownerPhoneNumber = phoneNumber.text;
      userController.user.value.ownerEmailAddress = email.text.trim();
      Get.offAll(const MyBottomNavigationBar());
      UserRepository userRepository = Get.find();
      userController.user.value.isRegistered = true;
      userRepository.updateUserField(userMdel: userController.user.value);
      log(userController.user.value.ownerPhoneNumber);
    }
  }

  @override
  void dispose() {
    // Dispose A01 fields
    courtName.dispose();
    courtPhoneNumber.dispose();
    courtEmailAddress.dispose();

    // Dispose A02 fields
    description.dispose();
    location.dispose();
    courtPrice.dispose();

    // Dispose A04 fields
    fullName.dispose();
    phoneNumber.dispose();
    email.dispose();

    super.dispose();
  }
}
