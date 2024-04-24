import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import '../../../../../utils/portion/textfield.dart';
import '../../../../../view_model/Getx/signup_controller/a04_signup_controller.dart';

class SignupTextFields extends StatelessWidget {
  final A04SignupController controller;

  const SignupTextFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          hintText: "Full Name",
          labelText: "Owner Full Name",
          controller: controller.fullNameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),
        MyTextField(
          labelText: "Owner Phone Number",
          hintText: 'Phone Number',
          controller: controller.phoneNumberController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
        MyTextField(
          labelText: "Owner Email",
          hintText: 'Email Address',
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email address';
            }
            if (!GetUtils.isEmail(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}
