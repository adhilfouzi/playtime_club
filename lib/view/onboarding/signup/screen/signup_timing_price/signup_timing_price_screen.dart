import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../model/controller/validator.dart';
import '../../../../../utils/portion/textfield.dart';
import '../../../../../utils/portion/timepicker.dart';
import '../../../../../view_model/onboarding/signup_controller/signup_controller.dart';
import '../../utils/appbar.dart';
import 'widget/signup_bottom_navigation_bar.dart';

class SignupTimingAndPriceScreen extends StatelessWidget {
  SignupTimingAndPriceScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.find();
    final height = MediaQuery.of(context).size.height;
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
                SizedBox(height: height * 0.1),
                MyTextField(
                  textInputAction: TextInputAction.next,
                  controller: controller.courtPrice,
                  labelText: 'Court Price as per hour',
                  validator: (value) =>
                      InputValidators.validateEmpty('Court Price', value),
                  hintText: "Eg: 1000",
                  keyboardType: TextInputType.number,
                ),
                TimePicker(
                  onTimeSelected: (openingTime, closingTime, isOpen24Hours) {
                    controller.openingTimeFetch = openingTime;
                    controller.closingTimeFetch = closingTime;
                    controller.isOpen24Hours.value = isOpen24Hours;
                  },
                ),
                SizedBox(height: height * 0.02),
                MyTextField(
                  textInputAction: TextInputAction.done,
                  controller: controller.location,
                  labelText: 'Court Location',
                  validator: (value) =>
                      InputValidators.validateEmpty('Location', value),
                  hintText: "Eg:  Malaparamba, Kozhikode, Kerala",
                  keyboardType: TextInputType.name,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SignupBottomNavigationBar(
          formKey: formKey,
          onSubmit: controller.submitA02,
          buttonText: 'Next',
        ),
      ),
    );
  }
}
