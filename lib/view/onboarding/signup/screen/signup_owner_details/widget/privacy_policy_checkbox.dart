import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../view_model/onboarding/signup/signup_controller.dart';

class PrivacyPolicyCheckbox extends StatelessWidget {
  final SignupController controller;

  const PrivacyPolicyCheckbox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Checkbox(
            onChanged: (newValue) {
              controller.privacyPolicyChecked.value = newValue!;
            },
            value: controller.privacyPolicyChecked.value,
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Text(
            'I agree with the Terms and Privacy Policy',
            style: TextStyle(
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    );
  }
}
