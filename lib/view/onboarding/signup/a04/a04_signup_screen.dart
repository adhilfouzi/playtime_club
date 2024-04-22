import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view_model/Getx/signup_controller/a04_signup_controller.dart';
import '../../../../utils/const/image_name.dart';
import '../../../../utils/portion/button.dart';
import '../../../../utils/portion/textfield.dart';
import '../utils/appbar.dart';

class A04SignupScreen extends StatelessWidget {
  A04SignupScreen({super.key});

  final A04SignupController controller = Get.put(A04SignupController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomBottomAppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(height: height * 0.1),
                const OwnerPhoto(),
                SignupTextFields(controller: controller),
                PrivacyPolicyCheckbox(controller: controller),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Button().mainButton('Submit', context, () {
            if (controller.formKey.currentState!.validate()) {
              controller.submit();
            }
          }),
        ),
      ),
    );
  }
}

class OwnerPhoto extends StatelessWidget {
  const OwnerPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.32,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(profile),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Owner photo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: width * 0.545,
                  child: const Text(
                    "Your Face should be visible completely. Image with Space & headphone will not be approved",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SignupTextFields extends StatelessWidget {
  final A04SignupController controller;

  const SignupTextFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          hintText: "Full Name",
          labelText: "Owner Full Name",
          controller: controller.fullNameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),
        MyTextField(
          labelText: "Owner Phone Number",
          hintText: 'Phone Number',
          controller: controller.phoneNumberController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
        MyTextField(
          labelText: "Owner Email",
          hintText: 'Email Address',
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email address';
            }
            if (!GetUtils.isEmail(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class PrivacyPolicyCheckbox extends StatelessWidget {
  final A04SignupController controller;

  const PrivacyPolicyCheckbox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Checkbox(
            onChanged: (newValue) {
              controller.privacyPolicyChecked.value = newValue!;
            },
            value: controller.privacyPolicyChecked.value,
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Text(
            'I agree with the Terms and Privacy Policy',
            style: TextStyle(
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    );
  }
}
