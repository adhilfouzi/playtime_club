import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view/course/profile/edit%20profile/choose_turftime.dart';
import 'package:owners_side_of_turf_booking/view/course/profile/edit%20profile/court_details_screen.dart';
import 'package:owners_side_of_turf_booking/view/course/profile/edit%20profile/court_price_screen.dart';
import 'package:owners_side_of_turf_booking/view/course/profile/edit%20profile/owner_details.dart';
import 'package:owners_side_of_turf_booking/view/course/profile/edit%20profile/turf_images.dart';
import 'package:owners_side_of_turf_booking/view/course/profile/edit%20profile/turf_location.dart';
import 'package:owners_side_of_turf_booking/view/course/profile/utils/profile_button.dart';

import '../../../../utils/appbar/titleonly_appbar.dart';
import '../../../../view_model/onboarding/signup/signup_controller.dart';

class BusinessProfile extends StatelessWidget {
  const BusinessProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.find();
    return Scaffold(
      appBar: const TitleOnlyAppBar(title: 'Business Profile'),
      body: SafeArea(
        child: Column(
          children: [
            ProfileButton(
                text: "Court Details",
                onPressed: () {
                  Get.to(CourtDetails(controller: controller));
                }),
            ProfileButton(
                text: "Court Price as per hour",
                onPressed: () {
                  Get.to(CourtPrice(controller: controller));
                }),
            ProfileButton(
                text: "Opening and Closing Time",
                onPressed: () {
                  Get.to(ChooseTurfTime(controller: controller));
                }),
            ProfileButton(
                text: "Court Location",
                onPressed: () {
                  Get.to(TurfLocation(controller: controller));
                }),
            ProfileButton(
                text: "Turf Images",
                onPressed: () {
                  Get.to(TurfImages(controller: controller));
                }),
            ProfileButton(
                text: "Owner Details",
                onPressed: () {
                  Get.to(OnwerDetails(controller: controller));
                }),
          ],
        ),
      ),
    );
  }
}
