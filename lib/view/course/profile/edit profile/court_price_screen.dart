import 'package:flutter/material.dart';
import 'package:owners_side_of_turf_booking/utils/appbar/titleonly_appbar.dart';

import '../../../../utils/portion/textfield.dart';
import '../../../../utils/portion/validator.dart';
import '../../../../view_model/onboarding/signup/signup_controller.dart';
import '../../../onboarding/signup/screen/signup_timing_price/widget/signup_bottom_navigation_bar.dart';

class CourtPrice extends StatelessWidget {
  final SignupController controller;
  CourtPrice({super.key, required this.controller});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TitleOnlyAppBar(title: "Court Price"),
        body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextField(
                  textInputAction: TextInputAction.next,
                  controller: controller.courtPrice,
                  labelText: 'Court Price as per hour',
                  validator: (value) =>
                      InputValidators.validateEmpty('Court Price', value),
                  hintText: "Eg: 1000",
                  keyboardType: TextInputType.number,
                ),
              ],
            )),
        bottomNavigationBar: SignupBottomNavigationBar(
            formKey: formKey,
            buttonText: 'Save',
            onSubmit: controller.submitPrice));
  }
}
