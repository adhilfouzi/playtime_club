import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view_model/Getx/business_registration_controller.dart';
import '../../../model/controller/validator.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';

class A01SignupScreen extends StatelessWidget {
  A01SignupScreen({super.key});

  final controller = Get.put(BusinessRegistration());
  final GlobalKey<FormState> a10FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: const CustomBottomAppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: height * 0.025),
          child: Form(
            key: a10FormKey,
            child: Column(
              children: [
                SizedBox(height: height * 0.2),
                MyTextField(
                  hintText: "Eg: Lions Turf",
                  labelText: 'Court Name',
                  controller: controller.courtNameTextEditingController,
                  validator: (value) =>
                      InputValidators.validateEmpty('Court Name', value),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                MyTextField(
                  hintText: 'Eg: 9865327412',
                  labelText: 'Court Contact Number',
                  validator: (value) =>
                      InputValidators.validatePhoneNumber(value),
                  controller: controller.courtPhoneNumberTextEditingController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                MyTextField(
                  hintText: 'Eg: lionsturf@gmail.com',
                  labelText: 'Court Email Address',
                  validator: (value) => InputValidators.validateEmail(value),
                  controller: controller.courtEmailAddressTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.025),
          child: Button().mainButton('Next', context, () {
            if (!a10FormKey.currentState!.validate()) return;

            controller.a01Submit();
          }),
        ),
      ),
    );
  }
}
