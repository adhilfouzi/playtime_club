import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../view_model/course/usermodel_controller.dart';
import '../../../../view_model/course/profile_controlller.dart';
import '../../../utils/const/image_name.dart';
import 'edit profile/edit_profile_screen.dart';
import 'utils/about_screen.dart';
import 'utils/profile_button.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final UserController controller = Get.find();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.02, horizontal: screenWidth * 0.0052),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                CachedNetworkImage(
                  imageUrl: controller.user.value.ownerPhoto,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                    radius: 64.0,
                    backgroundColor: Colors.white,
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: const CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    radius: 64.0,
                    backgroundImage: AssetImage(ImagePath.profile),
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  controller.user.value.courtName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.user.value.courtEmailAddress,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.08),
                ProfileButton(
                    text: 'Business Profile',
                    onPressed: () {
                      Get.to(const BusinessProfile());
                    }),
                ProfileButton(
                    text: 'Change Password',
                    onPressed: () {
                      ProfileController.changePassword(
                          controller.user.value.courtEmailAddress);
                    }),
                ProfileButton(
                    text: 'Help & FAQs',
                    onPressed: () {
                      ProfileController.helpAndFAQs();
                    }),
                ProfileButton(
                    text: 'Privacy Policy',
                    onPressed: () {
                      ProfileController.privacyPolicy();
                    }),
                ProfileButton(
                    text: 'Terms & Use',
                    onPressed: () {
                      ProfileController.termsUse();
                    }),
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
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
