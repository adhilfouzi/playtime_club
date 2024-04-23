import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/portion/snackbar.dart';
import '../../../../view/course/bottom_navigationbar_widget.dart';
import '../usermodel_controller.dart';

class A04SignupController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var privacyPolicyChecked = false.obs;

  @override
  void onInit() {
    super.onInit();
    final userController = Get.find<UserController>();
    fullNameController.text = userController.ownerFullName.value;
    phoneNumberController.text = userController.ownerPhoneNumber.value;
    emailController.text = userController.ownerEmailAddress.value;
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      if (!privacyPolicyChecked.value) {
        CustomSnackbar.showError("Need to accept the privacy & policy");
        return;
      }

      final userController = UserController();

      // Update UserController's values with signup data
      log("submit $fullNameController.toString()");

      userController.updateValues(
        ownerFullName: fullNameController.text,
        ownerPhoneNumber: phoneNumberController.text,
        ownerEmailAddress: emailController.text,
      );
      await userController.updataUser();
      Get.offAll(const MyBottomNavigationBar());
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
