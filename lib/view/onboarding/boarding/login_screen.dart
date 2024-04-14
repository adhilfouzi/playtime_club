import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/controller/validator.dart';
import '../../../utils/const/image_name.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';
import '../../../view_model/bloc/signin_bloc/signin_bloc.dart';
import '../../course/bottom_navigationbar_widget.dart';
import '../forget/forgetpassword/emailverification.dart';
import 'account_request_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocListener<SigninBloc, SigninState>(
            listener: (context, state) {
              if (state is SigninSuccess) {
                // Navigate to home screen on success
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyBottomNavigationBar()));
              } else if (state is SigninError) {
                // Show error message
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.error)));
                Navigator.of(context).pop();
              }
            },
            child: Form(
              key: loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: height * 0.3,
                    width: width,
                    child: Image.asset(logo),
                  ),
                  SizedBox(height: height * 0.05),
                  MyTextField(
                    textInputAction: TextInputAction.next,
                    controller: emailTextEditingController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => InputValidators.validateEmail(value),
                  ),
                  PasswordTextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordTextEditingController,
                  ),
                  SizedBox(height: height * 0.15),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EmailVerificationScreen()));
                      },
                      child: const Text("Forget password")),
                  Button().mainButton('Log in', context, () {
                    if (!loginKey.currentState!.validate()) return;
                    final email = emailTextEditingController.text;
                    final password = passwordTextEditingController.text;
                    context.read<SigninBloc>().add(SigninRequested(
                        email: email, password: password, context: context));
                  }),
                  SizedBox(height: height * 0.1),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AccountRequestScreen()));
                    },
                    child: const Text('Don’t have an account? '),
                  ),
                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
