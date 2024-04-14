import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/controller/validator.dart';
import '../../../model/data_model/user_model.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/snackbar.dart';
import '../../../utils/portion/textfield.dart';
import '../../../view_model/bloc/signup_bloc/signup_bloc.dart';
import 'login_screen.dart';

class AccountRequestScreen extends StatelessWidget {
  AccountRequestScreen({super.key});

  final nameOfUserTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final courtNameTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final descriptionTextEditingController = TextEditingController();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

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
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Dismiss'))
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: signupFormKey,
            child: BlocListener<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state is SignupError) {
                  CustomSnackBar.showError(context, state.error);
                  Navigator.of(context).pop();
                } else if (state is SignupSuccess) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  CustomSnackBar.showSuccess(context,
                      "You have successfully registered with PlaySpots. Our representative will contact soon! ");
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyTextField(
                    textInputAction: TextInputAction.next,
                    controller: nameOfUserTextEditingController,
                    labelText: 'Name of User',
                    validator: (value) =>
                        InputValidators.validateEmpty("Name of User", value),
                    hintText: "Eg: Najil",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    validator: (value) =>
                        InputValidators.validatePhoneNumber(value),
                    textInputAction: TextInputAction.next,
                    controller: phoneNumberTextEditingController,
                    labelText: 'Phone Number',
                    hintText: "Eg: 9876543210",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    textInputAction: TextInputAction.next,
                    controller: emailTextEditingController,
                    labelText: 'Email Address',
                    validator: (value) => InputValidators.validateEmail(value),
                    hintText: "Eg: name@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    textInputAction: TextInputAction.next,
                    controller: courtNameTextEditingController,
                    validator: (value) =>
                        InputValidators.validateEmpty(' Turf Name', value),
                    labelText: 'Court Name',
                    hintText: "Eg: Turf Name",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    textInputAction: TextInputAction.next,
                    controller: locationTextEditingController,
                    labelText: 'Location',
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
                    controller: descriptionTextEditingController,
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
            if (!signupFormKey.currentState!.validate()) return;
            UserRequestModel user = UserRequestModel(
              userName: nameOfUserTextEditingController.text.trim(),
              number: phoneNumberTextEditingController.text.trim(),
              email: emailTextEditingController.text.trim(),
              courtName: courtNameTextEditingController.text.trim(),
              location: locationTextEditingController.text,
              description: descriptionTextEditingController.text,
            );
            context
                .read<SignupBloc>()
                .add(SignupRequested(user: user, context: context));
          }),
        ),
      ),
    );
  }
}
