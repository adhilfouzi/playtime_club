import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/const/image_name.dart';
import '../../../view_model/Getx/business_registration_controller.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';

class A04SignupScreen extends StatelessWidget {
  A04SignupScreen({super.key});
  final BusinessRegistration controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: const CustomBottomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: controller.a40FormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: height * 0.1),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.02, horizontal: width * 0.05),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.32,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(
                            image: AssetImage(profile),
                          )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Owner photo',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: width * 0.545,
                            child: const Text(
                              "Your Face should be visible completely. Image with Space & headphone will not be approved",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              MyTextField(
                hintText: "Full Name",
                labelText: "Owner Full Name",
                controller: controller.fullNameTextEditingController,
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
                controller: controller.phoneNumberTextEditingController,
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
                controller: controller.emailTextEditingController,
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
              Row(
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
                        // color: ,
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Button().mainButton('Submit', context, () {
          if (controller.a40FormKey.currentState!.validate()) {
            controller.a04Submit();
          }
        }),
      ),
    ));
  }
}
