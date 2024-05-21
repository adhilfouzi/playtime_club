import 'package:flutter/material.dart';
import '../../../../../../utils/portion/validator.dart';
import '../../../../../../utils/portion/textfield.dart';
import '../../../../../../view_model/onboarding/signup/signup_controller.dart';
import '../../signup_timing_price/widget/description_text_field.dart';

class CourtDetailsTextFields extends StatelessWidget {
  final SignupController controller;

  const CourtDetailsTextFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextField(
          hintText: "Eg: Lions Turf",
          labelText: 'Court Name',
          controller: controller.courtName,
          validator: (value) =>
              InputValidators.validateEmpty('Court Name', value),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
        ),
        MyTextField(
          hintText: 'Eg: 9865327412',
          labelText: 'Court Contact Number',
          validator: (value) => InputValidators.validatePhoneNumber(value),
          controller: controller.courtPhoneNumber,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        // MyTextField(
        //   hintText: 'Eg: lionsturf@gmail.com',
        //   labelText: 'Court Email Address',
        //   validator: (value) => InputValidators.validateEmail(value),
        //   controller: controller.courtEmailAddress,
        //   keyboardType: TextInputType.emailAddress,
        //   textInputAction: TextInputAction.done,
        // ),
        DescriptionTextField(controller: controller),
      ],
    );
  }
}
