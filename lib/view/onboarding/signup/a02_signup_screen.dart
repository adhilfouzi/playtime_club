import 'package:flutter/material.dart';
import '../../../utils/const/colors.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import 'utils/fetch_location.dart';
import '../../../utils/portion/textfield.dart';
import '../../../utils/portion/timepicker.dart';
import 'a03_signup_screen.dart';

class A02SignupScreen extends StatelessWidget {
  A02SignupScreen({super.key});
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
        child: Column(
          children: [
            MyTextField(
              maxLines: 4,
              minLines: 4,
              maxLength: 450,
              buildCounter: (BuildContext context,
                  {int? currentLength, int? maxLength, bool? isFocused}) {
                bool isMaxLengthReached = currentLength! >= (maxLength ?? 450);
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
              hintText: 'About Business',
              controller: ownersNameTextEditingController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            MyTextField(
              maxLines: 3,
              hintText: 'Business Address',
              controller: businessNumberTextEditingController,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
            ),
            MyTextField(
              hintText: 'Email Address',
              controller: businessMailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
            ),
            TimePicker(
              onTimeSelected: (openingTime, closingTime) {
                // Do something with the selected times
                // For example, you can pass them to another widget
                // or store them in state management solution like Provider or Bloc
              },
            ),
            const LocationCaller(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.025),
        child: Button().mainButton('Next', context, () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const A03SignupScreen()),
          );
        }),
      ),
    ));
  }
}
