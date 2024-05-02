import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../model/backend/repositories/user/user_repositories.dart';
import '../../model/data_model/owner_model.dart';
import '../../utils/portion/loadingpopup.dart';
import '../../utils/portion/snackbar.dart';
import '../../view/onboarding/boarding/login_screen.dart';

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
      final ownerCredential = await AuthenticationRepository()
          .registerWithEmailAndPassword(emailTextEditingController.text.trim());
      OwnerModel owner = OwnerModel(
          id: ownerCredential.user!.uid,
          courtName: courtNameTextEditingController.text.trim(),
          courtPhoneNumber: phoneNumberTextEditingController.text.trim(),
          courtEmailAddress: emailTextEditingController.text.trim(),
          courtDescription: descriptionTextEditingController.text.trim(),
          openingTime: '',
          closingTime: '',
          courtLocation: locationTextEditingController.text.trim(),
          images: '',
          ownerPhoto: '',
          ownerFullName: nameOfUserTextEditingController.text.trim(),
          ownerPhoneNumber: '',
          ownerEmailAddress: "",
          is24h: false,
          isOwner: false,
          isRegistered: false);

      // Implement signup logic here (using your preferred service layer)

      // ... Perform signup process (e.g., call an API)
      await UserRepository().saveUserRecord(owner, ownerCredential.user!.uid);

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
