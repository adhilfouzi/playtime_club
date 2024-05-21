import 'package:flutter/material.dart';
import 'package:owners_side_of_turf_booking/utils/appbar/titleonly_appbar.dart';
import 'package:owners_side_of_turf_booking/view_model/onboarding/signup/signup_controller.dart';

import '../../../onboarding/signup/screen/signup_owner_details/widget/owner_photo.dart';
import '../../../onboarding/signup/screen/signup_owner_details/widget/owner_textfiled.dart';
import '../../../onboarding/signup/screen/signup_timing_price/widget/signup_bottom_navigation_bar.dart';

class OnwerDetails extends StatelessWidget {
  final SignupController controller;
  OnwerDetails({super.key, required this.controller});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TitleOnlyAppBar(title: "Owner Details"),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OwnerPhoto(controller: controller),
                OwnerTextFields(controller: controller),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SignupBottomNavigationBar(
            formKey: formKey,
            buttonText: 'Save',
            onSubmit: controller.submitOwner));
  }
}
