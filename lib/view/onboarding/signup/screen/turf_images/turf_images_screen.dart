import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/portion/button.dart';
import '../../../../../view_model/onboarding/signup/image_controller.dart';
import '../../../../../view_model/onboarding/signup/signup_controller.dart';
import '../../utils/appbar.dart';
import 'widget/image_grid.dart';

class SignupTurfImages extends StatelessWidget {
  const SignupTurfImages({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final SignupController controller = Get.find();
    final ImageController imageController = Get.find();

    return SafeArea(
      child: Scaffold(
        appBar: const SignupAppBar(
          noLeading: false,
        ),
        body: Column(
          children: [
            const Text('Upload minimum 3 images of your Business'),
            SizedBox(
              height: height * 0.02,
            ),
            const ImagesGrid(),
            SizedBox(height: height * 0.04),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Button().withAdd('Next', context, () {
            controller.submitA03();
          }, () {
            imageController.openDialog(false);
          }),
        ),
      ),
    );
  }
}
