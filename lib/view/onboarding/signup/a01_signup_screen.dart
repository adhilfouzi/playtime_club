import 'package:flutter/material.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';
import 'a02_signup_screen.dart';

class A01SignupScreen extends StatelessWidget {
  A01SignupScreen({super.key});
  final ownersNameTextEditingController = TextEditingController();
  final businessNameTextEditingController = TextEditingController();
  final businessNumberTextEditingController = TextEditingController();
  final businessMailTextEditingController = TextEditingController();

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.2),
              // MyTextField(
              //   hintText: 'Business Owner’s Name',
              //   controller: ownersNameTextEditingController,
              //   keyboardType: TextInputType.name,
              //   textInputAction: TextInputAction.next,
              // ),
              // SizedBox(height: 16.0),
              MyTextField(
                hintText: 'Business Name',
                controller: businessNameTextEditingController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              // SizedBox(height: 16.0),
              MyTextField(
                hintText: 'Business Contact Number',
                controller: businessNumberTextEditingController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              // SizedBox(height: 16.0),
              MyTextField(
                hintText: 'Email Address',
                controller: businessMailTextEditingController,
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
              MaterialPageRoute(builder: (context) => A02SignupScreen()),
            );
          }),
        ),
      ),
    );
  }
}
