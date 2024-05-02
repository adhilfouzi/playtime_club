import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../model/controller/validator.dart';
import '../../../../../utils/portion/textfield.dart';
import '../../../../../utils/portion/timepicker.dart';
import '../../../../../view_model/getx/signup_controller/a02_signup_controller.dart';
import '../../utils/appbar.dart';
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
                  onTimeSelected: (openingTime, closingTime, isOpen24Hours) {
                    controller.openingTimeFetch = openingTime;
                    controller.closingTimeFetch = closingTime;
                    controller.isOpen24Hours.value = isOpen24Hours;
                  },
                ),
                SizedBox(height: height * 0.02),
                MyTextField(
                  textInputAction: TextInputAction.next,
                  controller: controller.locationfindTextEditingController,
                  labelText: 'Court Location',
                  validator: (value) =>
                      InputValidators.validateEmpty('Location', value),
                  hintText: "Eg:  Malaparamba, Kozhikode, Kerala",
                  keyboardType: TextInputType.emailAddress,
                ),
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
