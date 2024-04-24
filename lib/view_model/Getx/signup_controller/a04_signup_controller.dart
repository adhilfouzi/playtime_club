import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/model/backend/repositories/user/user_repositories.dart';
import '../../../../utils/portion/snackbar.dart';
import '../../../../view/course/bottom_navigationbar_widget.dart';
import '../usermodel_controller.dart';

class A04SignupController extends GetxController {
  static A04SignupController get instance => Get.find();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var privacyPolicyChecked = false.obs;
  UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fullNameController.text = userController.user.value.ownerFullName;
    phoneNumberController.text = userController.user.value.ownerPhoneNumber;
    emailController.text = userController.user.value.ownerEmailAddress;
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      if (!privacyPolicyChecked.value) {
        CustomSnackbar.showError("Need to accept the privacy & policy");
        return;
      }
      userController.user.value.ownerFullName = fullNameController.text;
      userController.user.value.ownerPhoneNumber = phoneNumberController.text;
      userController.user.value.ownerEmailAddress = emailController.text.trim();
      Get.offAll(const MyBottomNavigationBar());
      UserRepository userRepository = Get.find();
      userController.user.value.isRegistered = true;
      userRepository.updateUserField(userMdel: userController.user.value);
      log(userController.user.value.ownerPhoneNumber);
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
