import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:owners_side_of_turf_booking/utils/portion/snackbar.dart';
import 'package:owners_side_of_turf_booking/view/onboarding/boarding/account_request_screen.dart';

import '../../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../../model/controller/validator.dart';
import '../../../utils/const/image_name.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/loadingpopup.dart';
import '../../../utils/portion/textfield.dart';
import '../../course/bottom_navigationbar_widget.dart';

class SigninController extends GetxController {
  var isLoading = false.obs;

  void signin(String email, String password, BuildContext context) async {
    isLoading.value = true;
    try {
      Get.to(() => const LoadingPopup()); // Using Get.to to navigate
      bool user = await AuthenticationRepository()
          .signInWithEmailAndPassword(email, password);

      if (user) {
        Get.offAll(() =>
            const MyBottomNavigationBar()); // Using Get.offAll to replace the current screen
      } else {
        // Handle error
        log("Some error happened");
      }
    } catch (e) {
      // Handle error
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class LoginScreen extends StatelessWidget {
  final SigninController signinController =
      Get.put(SigninController()); // Instantiate the controller

  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.3,
                  width: width,
                  child: Image.asset(logo),
                ),
                SizedBox(height: height * 0.05),
                MyTextField(
                  textInputAction: TextInputAction.next,
                  controller: emailTextEditingController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidators.validateEmail(value),
                ),
                PasswordTextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordTextEditingController,
                ),
                SizedBox(height: height * 0.1),
                TextButton(
                  onPressed: () {
                    CustomSnackbar.showForgotPasswordDialog();
                  },
                  child: const Text("Forget password"),
                ),
                Button().mainButton('Log in', context, () {
                  if (loginKey.currentState!.validate()) {
                    final email = emailTextEditingController.text;
                    final password = passwordTextEditingController.text;
                    signinController.signin(email, password, context);
                  }
                }),
                SizedBox(height: height * 0.1),
                TextButton(
                  onPressed: () {
                    Get.to(AccountRequestScreen());
                  },
                  child: const Text('Don’t have an account? '),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
