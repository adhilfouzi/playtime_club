import 'package:flutter/material.dart';
import '../../../model/controller/validator.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';
import 'a02_signup_screen.dart';

class A01SignupScreen extends StatelessWidget {
  A01SignupScreen({super.key});
  final courtNameTextEditingController = TextEditingController();
  final courtPhoneNumberTextEditingController = TextEditingController();
  final courtEmailAddressTextEditingController = TextEditingController();

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
          child: Column(
            children: [
              SizedBox(height: height * 0.2),
              MyTextField(
                hintText: "Eg: Lions Turf",
                labelText: 'Court Name',
                controller: courtNameTextEditingController,
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
                controller: courtPhoneNumberTextEditingController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              MyTextField(
                hintText: 'Eg: lionsturf@gmail.com',
                labelText: 'Court Email Address',
                validator: (value) => InputValidators.validateEmail(value),
                controller: courtEmailAddressTextEditingController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.025),
          child: Button().mainButton('Next', context, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => A02SignupScreen(
                        courtEmailAddress:
                            courtEmailAddressTextEditingController.text,
                        courtName: courtNameTextEditingController.text,
                        courtPhoneNumber:
                            courtPhoneNumberTextEditingController.text,
                      )),
            );
          }),
        ),
      ),
    );
  }
}
