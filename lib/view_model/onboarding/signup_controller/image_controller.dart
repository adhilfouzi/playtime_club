import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/backend/repositories/user/profile_image_repository.dart';
import '../../../model/backend/repositories/user/user_repositories.dart';
import '../../../utils/portion/snackbar.dart';
import '../../course/usermodel_controller.dart';

class ImageController extends GetxController {
  Rx<File?> imageProfile = Rx<File?>(null);
  Rx<String?> imagePath = ''.obs;

  final UserController user = Get.find();

  Future<void> getImage(ImageSource source, bool isProfile) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      } else {
        if (isProfile) {
          imageProfile.value = File(image.path);
          await uploadProfileImage(isProfile);
          imagePath = Rx<String?>(image.path);
        } else {}
      }
    } catch (e) {
      log('Failed image picker: $e');
    }
  }

  Future<void> uploadProfileImage(bool isProfile) async {
    try {
      if (imageProfile.value != null) {
        if (isProfile) {
          final imageUrl = await ProfileRepository.uploadImages(
              imageProfile.value!, isProfile);
          imagePath.value = imageUrl;
          log(imageUrl);
          await UserRepository()
              .updateSpecificField(fieldName: 'ownerPhoto', value: imageUrl);
          log("update Specific Field");
        } else {
          //turf images
        }

        await user.getUserRecord();
        CustomSnackbar.showSuccess('Profile image uploaded successfully');
      } else {
        log("imageProfile is null");
      }
    } catch (e) {
      log('Error uploading profile image: $e');
      CustomSnackbar.showError('Failed to upload profile image');
    }
  }

  void openDialog(bool isProfile) {
    Get.defaultDialog(
      title: '',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Choose Image From.......',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  getImage(ImageSource.camera, isProfile);
                  Get.back();
                },
                icon: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  getImage(ImageSource.gallery, isProfile);
                  Get.back();
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
