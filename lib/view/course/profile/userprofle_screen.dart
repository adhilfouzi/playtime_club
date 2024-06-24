import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../view_model/course/usermodel_controller.dart';
import '../head/bottom_navigationbar_widget.dart';
import 'utils/profile_avatar.dart';
import 'utils/profile_buttons.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final UserController controller = Get.find();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          Get.offAll(fullscreenDialog: true, const MyBottomNavigationBar());
        }
      },
      child: Scaffold(
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
                  ProfileAvatar(userPhotoUrl: controller.user.value.ownerPhoto),
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
                  const ProfileButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
