import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:owners_side_of_turf_booking/utils/portion/snackbar.dart';
import 'package:owners_side_of_turf_booking/view/onboarding/boarding/account_request_screen.dart';
import '../../../model/controller/validator.dart';
import '../../../utils/const/image_name.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';
import '../../../view_model/Getx/signincontroller.dart';

class LoginScreen extends StatelessWidget {
  final SigninController signinController =
      Get.put(SigninController()); // Instantiate the controller

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: signinController.loginKey,
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
                  controller: signinController.emailTextEditingController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidators.validateEmail(value),
                ),
                PasswordTextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  controller: signinController.passwordTextEditingController,
                ),
                SizedBox(height: height * 0.1),
                TextButton(
                  onPressed: () {
                    CustomSnackbar.showForgotPasswordDialog();
                  },
                  child: const Text("Forget password"),
                ),
                Button().mainButton('Log in', context, () {
                  signinController.signin();
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
