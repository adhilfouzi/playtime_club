import 'package:flutter/material.dart';
import '../../../utils/const/image_name.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';
import 'a06_signup_screen.dart';

class A05SignupScreen extends StatelessWidget {
  A05SignupScreen({super.key});
  final passwordTextEditingController = TextEditingController();
  final rePasswordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: const IntroAppbar(
          needLeading: true,
          actions: [],
          titleText: 'Create Password',
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * 0.25,
                width: width,
                child: Image.asset(logo),
              ),
              const Text('Create Password'),
              SizedBox(height: height * 0.05),
              PasswordTextField(
                textInputAction: TextInputAction.next,
                hintText: 'Enter Password',
                keyboardType: TextInputType.visiblePassword,
                controller: passwordTextEditingController,
              ),
              PasswordTextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                controller: rePasswordTextEditingController,
                hintText: 'Confirm Password',
              ),
              SizedBox(
                width: width * 0.9,
                child: const Text(
                  "Password must be at least 8 character long and include 1 capital letter and 1 symbol",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(height: height * 0.2),
              SizedBox(height: height * 0.04),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Button().mainButton('Verify', context, () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SubmissionSuccessful()));
          }),
        ),
      ),
    );
  }
}
