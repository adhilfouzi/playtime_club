import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/portion/timepicker.dart';
import '../../../../view_model/Getx/signup_controller/a02_signup_controller.dart';
import '../utils/appbar.dart';
import '../utils/fetch_location.dart';
import 'widget/a02_signup_bottom_navigation_bar.dart';
import 'widget/description_text_field.dart';

class A02SignupScreen extends StatelessWidget {
  A02SignupScreen({super.key});

  final A02SignupController controller = Get.put(A02SignupController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: const SignupAppBar(
          noLeading: false,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: height * 0.2),
                DescriptionTextField(controller: controller),
                TimePicker(
                  onTimeSelected: (openingTime, closingTime) {
                    controller.openingTimeFetch = openingTime;
                    controller.closingTimeFetch = closingTime;
                  },
                ),
                const LocationCaller(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: A02SignupBottomNavigationBar(
            formKey: formKey,
            controller: controller,
            height: height,
            width: width),
      ),
    );
  }
}
