import 'package:flutter/material.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import 'a04_signup_screen.dart';

class A03SignupScreen extends StatelessWidget {
  final String courtName;
  final String courtPhoneNumber;
  final String courtEmailAddress;
  final String courtDescription;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;
  final String courtLocation;
  const A03SignupScreen(
      {super.key,
      required this.courtName,
      required this.courtPhoneNumber,
      required this.courtEmailAddress,
      required this.courtDescription,
      required this.openingTime,
      required this.closingTime,
      required this.courtLocation});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: const CustomBottomAppBar(),
        body: Column(
          children: [
            const Text('Upload minimum 3 images of your Business'),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: const Card(
                      elevation: 5,
                      // child: Image.asset(
                      //   'assets/image/2.jpg',
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Button().withAdd('Next', context, () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => A04SignupScreen()));
          }, () {}),
        ),
      ),
    );
  }
}
