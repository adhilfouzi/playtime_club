import 'package:flutter/material.dart';

import '../../../../../model/controller/validator.dart';
import '../../../../../utils/portion/textfield.dart';
import '../../../../../view_model/Getx/signup_controller/a01signup_controller.dart';

class SignupTextFields extends StatelessWidget {
  final A01SignupController controller;

  const SignupTextFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          hintText: "Eg: Lions Turf",
          labelText: 'Court Name',
          controller: controller.courtNameController,
          validator: (value) =>
              InputValidators.validateEmpty('Court Name', value),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
        ),
        MyTextField(
          hintText: 'Eg: 9865327412',
          labelText: 'Court Contact Number',
          validator: (value) => InputValidators.validatePhoneNumber(value),
          controller: controller.courtPhoneNumberController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        MyTextField(
          hintText: 'Eg: lionsturf@gmail.com',
          labelText: 'Court Email Address',
          validator: (value) => InputValidators.validateEmail(value),
          controller: controller.courtEmailAddressController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
