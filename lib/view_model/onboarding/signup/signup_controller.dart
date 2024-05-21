import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/backend/repositories/user/user_repositories.dart';
import '../../../utils/portion/snackbar.dart';
import '../../../view/course/head/bottom_navigationbar_widget.dart';
import '../../../view/onboarding/signup/screen/turf_images/turf_images_screen.dart';
import '../../../view/onboarding/signup/screen/signup_timing_price/signup_timing_price_screen.dart';
import '../../../view/onboarding/signup/screen/signup_owner_details/signup_owner_details_screen.dart';
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
    userController.user.value.courtDescription = description.text;

    Get.to(SignupTimingAndPriceScreen());
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

    userController.user.value.openingTime = openingTimeFetch!;
    userController.user.value.courtLocation = location.text;
    userController.user.value.closingTime = closingTimeFetch!;
    userController.user.value.is24h = isOpen24Hours.value;
    userController.user.value.price = double.parse(courtPrice.text);

    Get.to(const SignupTurfImages());
    log(userController.user.value.price.toString());
    log(userController.user.value.openingTime.toString());
  }

  // A03 Methods
  void submitA03() {
    if (userController.user.value.images.length < 3) {
      CustomSnackbar.showError("Add at least 3 images of your Business");
    } else {
      Get.to(SignupOwnerDetailsScreen());
    }
  }

  // A04 Methods
  void submitA04() async {
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

  //court details
  void submitCourt() async {
    try {
      userController.user.value.courtName = courtName.text;
      userController.user.value.courtPhoneNumber = courtPhoneNumber.text;
      userController.user.value.courtEmailAddress =
          courtEmailAddress.text.toLowerCase().trim();
      userController.user.value.courtDescription = description.text;

      log(userController.user.value.courtPhoneNumber);
      await UserRepository()
          .updateUserField(userMdel: userController.user.value);
      Get.back();
    } catch (e) {
      log("submit Court: $e");
    }
  }

  //court proce as per hour
  void submitPrice() async {
    try {
      userController.user.value.price = double.parse(courtPrice.text);
      await UserRepository().updateSpecificField(
          fieldName: 'price', value: userController.user.value.price);
      Get.back();
    } catch (e) {
      log("submit Price:$e");
    }
  }

  //Opening and closing time
  void submitTime() async {
    try {
      if (openingTimeFetch == null && closingTimeFetch == null) {
        CustomSnackbar.showError('Please fill in all required fields.');
        return;
      }
      userController.user.value.openingTime = openingTimeFetch!;
      userController.user.value.closingTime = closingTimeFetch!;
      userController.user.value.is24h = isOpen24Hours.value;
      await UserRepository()
          .updateUserField(userMdel: userController.user.value);
      Get.back();
    } catch (e) {
      log("submit Time:$e");
    }
  }

  //court location
  void submitLocation() async {
    try {
      userController.user.value.courtLocation = location.text;
      await UserRepository().updateSpecificField(
          fieldName: 'courtLocation',
          value: userController.user.value.courtLocation);
      Get.back();
    } catch (e) {
      log("submit Location:$e");
    }
  }

  //turf image
  void turfImages() async {
    try {
      if (userController.user.value.images.length < 3) {
        CustomSnackbar.showError("Add at least 3 images of your Business");
      } else {
        Get.back();
      }
    } catch (e) {
      log("turf Images:$e");
    }
  }

  //owner Details
  void submitOwner() async {
    try {
      userController.user.value.ownerFullName = fullName.text;
      userController.user.value.ownerPhoneNumber = phoneNumber.text;
      userController.user.value.ownerEmailAddress = email.text.trim();
      Get.back();
      UserRepository().updateUserField(userMdel: userController.user.value);
      log(userController.user.value.ownerPhoneNumber);
    } catch (e) {
      log("submint Owner: $e");
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
