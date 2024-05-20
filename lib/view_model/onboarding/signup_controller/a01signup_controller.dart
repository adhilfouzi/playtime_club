// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../view/onboarding/signup/screen/a02/a02_signup_screen.dart';
// import '../../course/usermodel_controller.dart';

// class A01SignupController extends GetxController {
//   static A01SignupController get instance => Get.find();

//   final TextEditingController courtNameController = TextEditingController();
//   final TextEditingController courtPhoneNumberController =
//       TextEditingController();
//   final TextEditingController courtEmailAddressController =
//       TextEditingController();
//   UserController userController = Get.find();
//   @override
//   void onInit() {
//     super.onInit();
//     courtNameController.text = userController.user.value.courtName;
//     courtPhoneNumberController.text =
//         userController.user.value.courtPhoneNumber;
//     courtEmailAddressController.text =
//         userController.user.value.courtEmailAddress;
//   }

//   void submit() {
//     // You can perform any validation or logic here
//     userController.user.value.courtName = courtNameController.text;

//     userController.user.value.courtPhoneNumber =
//         courtPhoneNumberController.text;

//     userController.user.value.courtEmailAddress =
//         courtEmailAddressController.text.trim();

//     Get.to(A02SignupScreen());
//     log(userController.user.value.courtPhoneNumber);
//   }

//   @override
//   void dispose() {
//     courtNameController.dispose();
//     courtPhoneNumberController.dispose();
//     courtEmailAddressController.dispose();
//     super.dispose();
//   }
// }
