import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../data_model/owner_model.dart';
import '../authentication/firebase_authentication.dart';
import '../authentication/firebase_exceptionhandler.dart';

class UserRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Save user data to Firestore
  Future<void> saveUserRecord(OwnerModel user, String id) async {
    try {
      await _db.collection("Owner").doc(id).set(user.toJson());
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Fetch user data from Firestore without user ID
  Future<OwnerModel> getUserById() async {
    try {
      DocumentSnapshot snapshot = await _db
          .collection("Owner")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();
      if (snapshot.exists) {
        return OwnerModel.fromSnapshot(snapshot);
      } else {
        return OwnerModel.emptyOwnerModel();
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Fetch user data from Firestore by user ID
  Future<OwnerModel> fetchUserdetails(String? id) async {
    try {
      DocumentSnapshot snapshot = await _db.collection("Owner").doc(id).get();
      if (snapshot.exists) {
        return OwnerModel.fromSnapshot(snapshot);
      } else {
        return OwnerModel.emptyOwnerModel();
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Update a specific field in a user's collection
  Future<void> updateSpecificField(
      {required String fieldName, required dynamic value}) async {
    try {
      await _db
          .collection("Owner")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .update({
        fieldName: value,
      });
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<void> updateUserField({required OwnerModel userMdel}) async {
    try {
      await _db
          .collection("Owner")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .update(userMdel.toJson());
      log('updateUserField');
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Remove user data from Firestore
  Future<void> removeUserRecord() async {
    try {
      await _db
          .collection("Owner")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .delete();
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Upload a user profile
  Future<void> uploadUserProfile(String id, String profileImagePath) async {
    // Implement the logic to upload user profile image to storage and update user document with the image path
  }

  /// Upload a group of turf images
  Future<void> uploadTurfImages(String id, List<String> imagePaths) async {
    // Implement the logic to upload turf images to storage and update user document with the image paths
  }
}
