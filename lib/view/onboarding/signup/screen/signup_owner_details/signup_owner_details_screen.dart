import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view/onboarding/signup/screen/signup_timing_price/widget/signup_bottom_navigation_bar.dart';
import 'package:owners_side_of_turf_booking/view/onboarding/signup/screen/signup_owner_details/widget/owner_textfiled.dart';
import '../../../../../view_model/onboarding/signup/signup_controller.dart';
import '../../utils/appbar.dart';
import 'widget/owner_photo.dart';
import 'widget/privacy_policy_checkbox.dart';

class SignupOwnerDetailsScreen extends StatelessWidget {
  SignupOwnerDetailsScreen({super.key});

  final SignupController controller = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          appBar: const SignupAppBar(
            noLeading: false,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: height * 0.1),
                  OwnerPhoto(controller: controller),
                  OwnerTextFields(controller: controller),
                  SizedBox(
                    child: controller.userController.user.value.isRegistered
                        ? null
                        : PrivacyPolicyCheckbox(controller: controller),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SignupBottomNavigationBar(
              formKey: formKey,
              buttonText: 'Submit',
              onSubmit: controller.submitA04)),
    );
  }
}
