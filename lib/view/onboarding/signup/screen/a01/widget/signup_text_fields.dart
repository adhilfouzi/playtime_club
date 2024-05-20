import 'package:flutter/material.dart';
import '../../../../../../model/controller/validator.dart';
import '../../../../../../utils/portion/textfield.dart';
import '../../../../../../view_model/onboarding/signup_controller/signup_controller.dart';

class SignupTextFields extends StatelessWidget {
  final SignupController controller;

  const SignupTextFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        MyTextField(
          hintText: 'Eg: lionsturf@gmail.com',
          labelText: 'Court Email Address',
          validator: (value) => InputValidators.validateEmail(value),
          controller: controller.courtEmailAddress,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
