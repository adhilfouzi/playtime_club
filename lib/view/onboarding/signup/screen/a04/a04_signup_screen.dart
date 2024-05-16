import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view/onboarding/signup/screen/a04/widget/a04_textfiled.dart';
import '../../../../../utils/portion/button.dart';
import '../../../../../view_model/onboarding/signup_controller/a04_signup_controller.dart';
import '../../utils/appbar.dart';
import 'widget/owner_photo.dart';
import 'widget/privacy_policy_checkbox.dart';

class A04SignupScreen extends StatelessWidget {
  A04SignupScreen({super.key});

  final A04SignupController controller = Get.put(A04SignupController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: const SignupAppBar(
          noLeading: false,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(height: height * 0.1),
                OwnerPhoto(controller: controller),
                SignupTextFields(controller: controller),
                SizedBox(
                  child: controller.userController.user.value.isRegistered
                      ? null
                      : PrivacyPolicyCheckbox(controller: controller),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Button().mainButton('Submit', context, () {
            if (controller.formKey.currentState!.validate()) {
              controller.submit();
            }
          }),
        ),
      ),
    );
  }
}
