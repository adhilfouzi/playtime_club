import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../view_model/course/profile_controlller.dart';
import '../../../../view_model/course/usermodel_controller.dart';
import '../edit profile/edit_profile_screen.dart';
import 'about_screen.dart';
import 'profile_button.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileButton(
          text: 'Business Profile',
          onPressed: () {
            Get.to(const BusinessProfile());
          },
        ),
        ProfileButton(
          text: 'Change Password',
          onPressed: () {
            ProfileController.changePassword(
                Get.find<UserController>().user.value.courtEmailAddress);
          },
        ),
        ProfileButton(
          text: 'Help & FAQs',
          onPressed: () {
            ProfileController.helpAndFAQs();
          },
        ),
        ProfileButton(
          text: 'Privacy Policy',
          onPressed: () {
            ProfileController.privacyPolicy();
          },
        ),
        ProfileButton(
          text: 'Terms & Use',
          onPressed: () {
            ProfileController.termsUse();
          },
        ),
        ProfileButton(
          text: 'About Us',
          onPressed: () {
            Get.to(() => const AboutUsScreen());
          },
        ),
        ProfileButton(
          text: 'Log Out',
          onPressed: () {
            ProfileController.logout();
          },
        ),
      ],
    );
  }
}
