import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view/onboarding/boarding/login_screen.dart';
import '../../../model/data_model/user_request_model.dart';
import '../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../model/backend/repositories/user/user_repositories.dart';
import '../../utils/portion/loadingpopup.dart';
import '../../utils/portion/snackbar.dart';

class AccountRequestController extends GetxController {
  final nameOfUserTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final courtNameTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final descriptionTextEditingController = TextEditingController();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final RxBool isLoading = RxBool(false); // Use RxBool for loading state

  void submitRequest() async {
    try {
      if (!signupFormKey.currentState!.validate()) return;
      Get.to(() => const LoadingPopup());
      UserModel user = UserModel(
        courtName: courtNameTextEditingController.text.trim(),
        courtPhoneNumber: phoneNumberTextEditingController.text.trim(),
        courtEmailAddress: emailTextEditingController.text.trim(),
        courtDescription: descriptionTextEditingController.text.trim(),
        openingTime: '',
        closingTime: '',
        courtLocation: locationTextEditingController.text.trim(),
        images: '', // Implement image handling
        ownerPhoto: '', // Implement owner photo handling
        ownerFullName: nameOfUserTextEditingController.text.trim(),
        ownerPhoneNumber: phoneNumberTextEditingController.text.trim(),
        ownerEmailAddress: "",
        isOwner: true,
      );

      // Implement signup logic here (using your preferred service layer)
      final userCredential = await AuthenticationRepository()
          .registerWithEmailAndPassword(user.courtEmailAddress);
      // ... Perform signup process (e.g., call an API)
      await UserRepository().saveUserRecord(user, userCredential.user!.uid);

      // ...
      Get.off(LoginScreen());
      // Handle success or error states using GetX Snackbars (optional)
      CustomSnackbar.showSuccess('Signup successful!');
    } catch (e) {
      Get.back();
      log(e.toString());
      CustomSnackbar.showError(e.toString());
    }
  }
}
