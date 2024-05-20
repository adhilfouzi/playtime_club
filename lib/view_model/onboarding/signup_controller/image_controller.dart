import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../model/backend/repositories/user/profile_image_repository.dart';
import '../../../model/backend/repositories/user/user_repositories.dart';
import '../../../utils/portion/snackbar.dart';
import '../../course/usermodel_controller.dart';
import 'package:path/path.dart' as path;

class ImageController extends GetxController {
  Rx<File?> imageProfile = Rx<File?>(null);
  Rx<File?> turfImages = Rx<File?>(null);

  final UserController user = Get.find();

  Future<void> getImage(ImageSource source, bool isProfile) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      var imageFile = File(image.path);
      log('Original file size: ${imageFile.lengthSync()} bytes');
      imageFile = await testCompressAndGetFile(imageFile);
      log('Compressed file size: ${imageFile.lengthSync()} bytes');

      if (isProfile) {
        imageProfile.value = imageFile;
        await uploadProfileImage(isProfile);
      } else {
        turfImages.value = imageFile;
        await uploadTurfImages();
      }
    } catch (e) {
      log('Failed image picker: $e');
      CustomSnackbar.showError('Failed to pick image');
    }
  }

  Future<File> testCompressAndGetFile(File file) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String targetPath =
          path.join(tempDir.path, 'compressed_${path.basename(file.path)}');
      final XFile? compressedXFile =
          await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 20,
      );
      if (compressedXFile == null) {
        throw Exception("Compression failed.");
      }

      return File(compressedXFile.path);
    } catch (e) {
      log("testCompressAndGetFile:$e");
      rethrow;
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

  Future<void> deleteTurfImage(int index) async {
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
                    deleteTurfImage(index);
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
