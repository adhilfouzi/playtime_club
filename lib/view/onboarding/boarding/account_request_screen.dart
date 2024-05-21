import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/portion/validator.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';
import '../../../view_model/onboarding/signin/accountrequest_controller.dart';
import 'login_screen.dart';

class AccountRequestScreen extends StatelessWidget {
  AccountRequestScreen({super.key});

  final controller = Get.put(AccountRequestController()); // Create an instance

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () => Get.off(LoginScreen()),
              child: const Text('Dismiss'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: GetBuilder<AccountRequestController>(
            builder: (_) => Form(
              key: controller.signupFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyTextField(
                    textInputAction: TextInputAction.next,
                    controller: controller.nameOfUserTextEditingController,
                    labelText: 'Name of User',
                    validator: (value) =>
                        InputValidators.validateEmpty("Name of User", value),
                    hintText: "Eg: Najil",
                    keyboardType: TextInputType.name,
                  ),
                  MyTextField(
                    validator: (value) =>
                        InputValidators.validatePhoneNumber(value),
                    textInputAction: TextInputAction.next,
                    controller: controller.phoneNumberTextEditingController,
                    labelText: 'Court Phone Number',
                    hintText: "Eg: 9876543210",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    textInputAction: TextInputAction.next,
                    controller: controller.emailTextEditingController,
                    labelText: 'Court Email Address',
                    validator: (value) => InputValidators.validateEmail(value),
                    hintText: "Eg: name@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    textInputAction: TextInputAction.next,
                    controller: controller.courtNameTextEditingController,
                    validator: (value) =>
                        InputValidators.validateEmpty(' Turf Name', value),
                    labelText: 'Court Name',
                    hintText: "Eg: Turf Name",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    textInputAction: TextInputAction.next,
                    controller: controller.locationTextEditingController,
                    labelText: 'Court Location',
                    validator: (value) =>
                        InputValidators.validateEmpty('Location', value),
                    hintText: "Eg:  Malaparamba, Kozhikode, Kerala",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    maxLines: 4,
                    minLines: 4,
                    maxLength: 450,
                    buildCounter: (BuildContext context,
                        {int? currentLength, int? maxLength, bool? isFocused}) {
                      bool isMaxLengthReached =
                          currentLength! >= (maxLength ?? 450);
                      return Text(
                        isMaxLengthReached
                            ? 'Max length reached'
                            : '$currentLength / ${450}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isFocused != null && isFocused
                              ? isMaxLengthReached
                                  ? Colors.red
                                  : CustomColor.mainColor
                              : Colors.grey,
                        ),
                      );
                    },
                    labelText: 'About Business',
                    hintText: "Describe about your court",
                    controller: controller.descriptionTextEditingController,
                    validator: (value) =>
                        InputValidators.validateEmpty('description', value),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Button().mainButton('Register', context, () {
            controller.submitRequest();
          }),
        ),
      ),
    );
  }
}
