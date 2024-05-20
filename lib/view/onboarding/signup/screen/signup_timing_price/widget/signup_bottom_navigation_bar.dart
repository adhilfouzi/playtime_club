import 'package:flutter/material.dart';
import '../../../../../../utils/portion/button.dart';

class SignupBottomNavigationBar extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String buttonText;
  final VoidCallback onSubmit;

  const SignupBottomNavigationBar({
    super.key,
    required this.formKey,
    required this.buttonText,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.025),
      child: Button().mainButton(buttonText, context, () {
        if (!formKey.currentState!.validate()) return;
        onSubmit();
      }),
    );
  }
}

class SignupBottomNavigationBarWithOutFormKey extends StatelessWidget {
  final String buttonText;
  final VoidCallback onSubmit;
  final VoidCallback onImageSubmit;

  const SignupBottomNavigationBarWithOutFormKey({
    super.key,
    required this.buttonText,
    required this.onSubmit,
    required this.onImageSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.025),
      child: Button().withAdd(buttonText, context, () {
        onSubmit();
      }, () {
        onImageSubmit();
      }),
    );
  }
}
