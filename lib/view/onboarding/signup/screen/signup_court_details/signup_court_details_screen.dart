import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../view_model/onboarding/signup/signup_controller.dart';
import '../../utils/appbar.dart';
import '../signup_timing_price/widget/signup_bottom_navigation_bar.dart';
import 'widget/signup_text_fields.dart';

class SignupCourtDetailsScreen extends StatelessWidget {
  SignupCourtDetailsScreen({super.key});

  final SignupController controller = Get.put(SignupController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: const SignupAppBar(noLeading: true),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: height * 0.025),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: height * 0.05),
                CourtDetailsTextFields(controller: controller),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SignupBottomNavigationBar(
          formKey: formKey,
          onSubmit: controller.submitA01,
          buttonText: 'Next',
        ),
      ),
    );
  }
}
