import 'package:flutter/material.dart';
import 'package:owners_side_of_turf_booking/utils/appbar/titleonly_appbar.dart';
import 'package:owners_side_of_turf_booking/view/onboarding/signup/screen/signup_timing_price/widget/signup_bottom_navigation_bar.dart';
import 'package:owners_side_of_turf_booking/view_model/onboarding/signup/signup_controller.dart';

import '../../../../utils/portion/textfield.dart';
import '../../../../utils/portion/validator.dart';

class TurfLocation extends StatelessWidget {
  final SignupController controller;
  TurfLocation({super.key, required this.controller});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleOnlyAppBar(title: 'Turf Location'),
      body: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(
            textInputAction: TextInputAction.done,
            controller: controller.location,
            labelText: 'Court Location',
            validator: (value) =>
                InputValidators.validateEmpty('Location', value),
            hintText: "Eg:  Malaparamba, Kozhikode, Kerala",
            keyboardType: TextInputType.name,
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigation(
          buttonText: "Save", onSubmit: controller.submitLocation),
    );
  }
}
