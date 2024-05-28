import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../utils/const/colors.dart';
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
                child: CachedNetworkImage(
                  imageUrl: userController.user.value.ownerPhoto,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                    radius: 80.0,
                    backgroundColor: Colors.grey.shade200,
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: CustomColor.mainColor,
                        radius: 20.0,
                        child: Icon(
                          Icons.camera_alt,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 80.0,
                    backgroundImage: const AssetImage(profile),
                    backgroundColor: Colors.grey.shade200,
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: CustomColor.mainColor,
                        radius: 20.0,
                        child: Icon(
                          Icons.camera_alt,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
                    "Your face should be completely visible. Images with space and headphones will not be approved.",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
