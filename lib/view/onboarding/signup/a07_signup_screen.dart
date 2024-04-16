import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owners_side_of_turf_booking/view/course/bottom_navigationbar_widget.dart';
import '../../../utils/const/image_name.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';
import '../../../view_model/checkbox_cubit.dart';

class A07SignupScreen extends StatelessWidget {
  A07SignupScreen({super.key});
  final fullNameTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final checkboxCubit = context.read<CheckboxCubit>();
    return SafeArea(
        child: Scaffold(
      appBar: const CustomBottomAppBar(),
      body: SingleChildScrollView(
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
              controller: fullNameTextEditingController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            MyTextField(
              labelText: "Owner Phone Number",
              hintText: 'Phone Number',
              controller: phoneNumberTextEditingController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            MyTextField(
              labelText: "Owner Email",
              hintText: 'Email Address',
              controller: emailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CheckboxCubit, bool>(
                  builder: (context, isChecked) {
                    return Checkbox(
                      value: isChecked,
                      onChanged: (newValue) {
                        checkboxCubit.privacyPolicyChecked(newValue!);
                      },
                    );
                  },
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
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Button().mainButton('Submit', context, () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MyBottomNavigationBar()));
        }),
      ),
    ));
  }
}
