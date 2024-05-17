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
  Rx<File?> turfImages = Rx<File?>(null);

  final UserController user = Get.find();

  // @override
  // void onInit() {
  //   super.onInit();
  //   List<String> imageUrls = user.user.value.images;
  //   turfImages.value = imageUrls.map((url) => File(url)).toList();
  // }

  Future<void> getImage(ImageSource source, bool isProfile) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      } else {
        if (isProfile) {
          imageProfile.value = File(image.path);
          await uploadProfileImage(isProfile);
        } else {
          turfImages.value = File(image.path);
          await uploadTurfImages();
        }
      }
    } catch (e) {
      log('Failed image picker: $e');
    }
  }

  Future<void> uploadProfileImage(bool isProfile) async {
    try {
      if (imageProfile.value != null) {
        final imageUrl = await ProfileRepository.uploadImages(
            imageProfile.value!, isProfile);
        await UserRepository()
            .updateSpecificField(fieldName: 'ownerPhoto', value: imageUrl);
      } else {
        log("imageProfile is null");
      }

      await user.getUserRecord();
      CustomSnackbar.showSuccess('Profile image uploaded successfully');
    } catch (e) {
      log('Error uploading profile image: $e');
      CustomSnackbar.showError('Failed to upload profile image');
    }
  }

  Future<void> uploadTurfImages() async {
    try {
      // Fetch the current list of image URLs from Firestore
      List<String> existingImageUrls = user.user.value.images;
      if (turfImages.value != null) {
        String imageUrl =
            await ProfileRepository.uploadImages(turfImages.value!, false);
        // Combine the existing image URLs with the new image URLs
        existingImageUrls.add(imageUrl);
      }

      // Update user's turf images in Firestore with the combined list
      await UserRepository()
          .updateSpecificField(fieldName: 'images', value: existingImageUrls);
    } catch (e) {
      log('Error uploading turf images: $e');
      CustomSnackbar.showError('Failed to upload turf images');
    } finally {
      // Refresh user record
      await user.getUserRecord();
    }
  }

  Future<void> deleteTurfImages(int index) async {
    try {
      List<String> images = user.user.value.images;
      log("Index: $index");
      log("images.length: ${images.length}");
      images.removeAt(index);
      log("images.length after remove: ${images.length}");

      // Update user's turf images in Firestore
      await UserRepository()
          .updateSpecificField(fieldName: 'images', value: images);
      CustomSnackbar.showSuccess('Delete turf images');
    } catch (e) {
      log('Error delete turf images: $e');
      CustomSnackbar.showError('Failed to delete turf images');
    } finally {
      // Refresh user record
      await user.getUserRecord();
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

  void aDialogforDelete(int index) {
    Get.defaultDialog(
      title: '',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Are you sure you want to delete the image?',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    deleteTurfImages(index);
                    Get.back();
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("No")),
            ],
          ),
        ],
      ),
    );
  }
}
