import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../view_model/getx/signup_controller/a01signup_controller.dart';
import '../../utils/appbar.dart';
import 'widget/a01_signup_bottom_navigation_bar.dart';
import 'widget/signup_text_fields.dart';

class A01SignupScreen extends StatelessWidget {
  A01SignupScreen({super.key});

  final A01SignupController controller = Get.put(A01SignupController());
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
              children: [
                SizedBox(height: height * 0.2),
                SignupTextFields(controller: controller),
              ],
            ),
          ),
        ),
        bottomNavigationBar: A01SignupBottomNavigationBar(
          formKey: formKey,
          controller: controller,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
