import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/appbar/titleonly_appbar.dart';
import '../../../../view_model/onboarding/signup/image_controller.dart';
import '../../../../view_model/onboarding/signup/signup_controller.dart';
import '../../../onboarding/signup/screen/signup_timing_price/widget/signup_bottom_navigation_bar.dart';
import '../../../onboarding/signup/screen/turf_images/widget/image_grid.dart';

class TurfImages extends StatelessWidget {
  final SignupController controller;
  const TurfImages({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.find();

    return Scaffold(
      appBar: const TitleOnlyAppBar(title: "Turf Image"),
      body: const Column(
        children: [
          ImagesGrid(),
        ],
      ),
      bottomNavigationBar: SignupBottomNavigationBarWithOutFormKey(
          buttonText: "Save",
          onSubmit: () {
            controller.turfImages();
          },
          onImageSubmit: () {
            imageController.openDialog(false);
          }),
    );
  }
}
