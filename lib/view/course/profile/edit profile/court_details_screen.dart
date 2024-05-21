import 'package:flutter/material.dart';
import 'package:owners_side_of_turf_booking/utils/appbar/titleonly_appbar.dart';

import '../../../../view_model/onboarding/signup/signup_controller.dart';
import '../../../onboarding/signup/screen/signup_court_details/widget/signup_text_fields.dart';
import '../../../onboarding/signup/screen/signup_timing_price/widget/signup_bottom_navigation_bar.dart';

class CourtDetails extends StatelessWidget {
  final SignupController controller;
  CourtDetails({super.key, required this.controller});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: const TitleOnlyAppBar(title: "Court Details"),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CourtDetailsTextFields(controller: controller),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SignupBottomNavigationBar(
            formKey: formKey,
            buttonText: 'Save',
            onSubmit: () {
              controller.submitCourt();
            }));
  }
}
