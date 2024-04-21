import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/Getx/business_registration_controller.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';

class A03SignupScreen extends StatelessWidget {
  A03SignupScreen({
    super.key,
  });
  final controller = Get.put(BusinessRegistration());

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
            controller.a03Submit();
          }, () {}),
        ),
      ),
    );
  }
}
