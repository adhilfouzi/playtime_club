import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/const/image_name.dart';
import '../../../../../../view_model/course/usermodel_controller.dart';
import '../../../../../../view_model/onboarding/signup/image_controller.dart';
import '../../../../../../view_model/onboarding/signup/signup_controller.dart';

class OwnerPhoto extends StatelessWidget {
  final SignupController controller;
  const OwnerPhoto({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final UserController userController = Get.find();
    final ImageController image = Get.find();
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.32,
            child: Obx(
              () => GestureDetector(
                onTap: () => image.openDialog(true),
                child: CircleAvatar(
                  backgroundImage:
                      userController.user.value.ownerPhoto.isNotEmpty
                          ? NetworkImage(userController.user.value.ownerPhoto)
                          : const AssetImage(profile) as ImageProvider,
                  radius: 64.0,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Owner photo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: width * 0.545,
                  child: const Text(
                    "Your Face should be visible completely. Image with Space & headphone will not be approved",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
