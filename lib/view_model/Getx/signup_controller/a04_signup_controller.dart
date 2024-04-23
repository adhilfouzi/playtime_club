import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/portion/snackbar.dart';
import '../../../../view/course/bottom_navigationbar_widget.dart';

class A04SignupController extends GetxController {
  static A04SignupController get instance => Get.find();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var privacyPolicyChecked = false.obs;

  void submit() {
    if (formKey.currentState!.validate()) {
      if (!privacyPolicyChecked.value) {
        CustomSnackbar.showError("Need to accept the privacy & policy");
        return;
      }
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
