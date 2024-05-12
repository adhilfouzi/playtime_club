import 'package:flutter/material.dart';

import '../../../../../../utils/portion/button.dart';
import '../../../../../../view_model/onboarding/signup_controller/a02_signup_controller.dart';

class A02SignupBottomNavigationBar extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final A02SignupController controller;
  final double height;
  final double width;

  const A02SignupBottomNavigationBar({
    super.key,
    required this.formKey,
    required this.controller,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.025),
      child: Button().mainButton('Next', context, () {
        if (!formKey.currentState!.validate()) return;

        controller.submit();
      }),
    );
  }
}
