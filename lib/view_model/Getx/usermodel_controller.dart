import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/model/backend/repositories/authentication/firebase_authentication.dart';
import 'package:owners_side_of_turf_booking/model/data_model/user_request_model.dart';

import '../../model/backend/repositories/user/user_repositories.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  UserController() {
    authUser = AuthenticationRepository().authUser;
    getUserRecord();
  }

  final userRepository = Get.put(UserRepository());

  //variable
  final RxString id = ''.obs;
  final RxString courtName = ''.obs;
  final RxString courtPhoneNumber = ''.obs;
  final RxString courtEmailAddress = ''.obs;
  final RxString courtDescription = ''.obs;
  final RxString openingTime = ''.obs;
  final RxString closingTime = ''.obs;
  final RxString courtLocation = ''.obs;
  final RxString images = ''.obs;
  final RxString ownerPhoto = ''.obs;
  final RxString ownerFullName = ''.obs;
  final RxString ownerPhoneNumber = ''.obs;
  final RxString ownerEmailAddress = ''.obs;
  final RxBool isOwner = true.obs;
  final RxBool isRegistered = false.obs;

  late User? authUser; // Initialize as null

  @override
  void onInit() {
    super.onInit();
    authUser = AuthenticationRepository().authUser;
    if (authUser != null) {
      getUserRecord();
    } else {
      print("User not authenticated.");
    }
  }

  Future<void> updataUser() async {
    UserModel user = UserModel(
        courtName: courtName.value,
        courtPhoneNumber: courtPhoneNumber.value,
        courtEmailAddress: courtEmailAddress.value,
        courtDescription: courtDescription.value,
        openingTime: openingTime.value,
        closingTime: closingTime.value,
        courtLocation: courtLocation.value,
        images: images.value,
        ownerPhoto: ownerPhoto.value,
        ownerFullName: ownerFullName.value,
        ownerPhoneNumber: ownerPhoneNumber.value,
        ownerEmailAddress: ownerEmailAddress.value,
        isOwner: isOwner.value,
        isRegistered: isRegistered.value);

    await userRepository.saveUserRecord(user, authUser!.uid);
    log("updataUser ${courtName.value}");
  }

  Future<void> getUserRecord() async {
    try {
      if (authUser != null) {
        final user = await userRepository.getUserById((authUser!.uid));
        TimeOfDay? openingTime;
        TimeOfDay? closingTime;
        // Convert string representations of time to TimeOfDay objects
        if (user.openingTime != "") {
          final openingTimeParts = user.openingTime.split(':');
          final closingTimeParts = user.closingTime.split(':');

          openingTime = TimeOfDay(
            hour: int.parse(openingTimeParts[0]),
            minute: int.parse(openingTimeParts[1]),
          );

          closingTime = TimeOfDay(
            hour: int.parse(closingTimeParts[0]),
            minute: int.parse(closingTimeParts[1]),
          );
        }

        updateValues(
          id: AuthenticationRepository().authUser!.uid,
          courtName: user.courtName,
          courtPhoneNumber: user.courtPhoneNumber,
          courtEmailAddress: user.courtEmailAddress,
          courtDescription: user.courtDescription,
          openingTime: openingTime,
          closingTime: closingTime,
          courtLocation: user.courtLocation,
          images: user.images,
          ownerPhoto: user.ownerPhoto,
          ownerFullName: user.ownerFullName,
          ownerPhoneNumber: user.ownerPhoneNumber,
          ownerEmailAddress: user.ownerEmailAddress,
          isOwner: user.isOwner,
          isRegistered: user.isRegistered,
        );
        log("user.courtPhoneNumber: ${user.courtPhoneNumber}");
        log("user.courtName: ${user.courtName}");
        log("getUserRecord ${courtName.value}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void updateValues({
    String? id,
    String? courtName,
    String? courtPhoneNumber,
    String? courtEmailAddress,
    String? courtDescription,
    TimeOfDay? openingTime,
    TimeOfDay? closingTime,
    String? courtLocation,
    String? images,
    String? ownerPhoto,
    String? ownerFullName,
    String? ownerPhoneNumber,
    String? ownerEmailAddress,
    bool? isOwner,
    bool? isRegistered,
  }) {
    this.courtName.value = courtName ?? this.courtName.value;
    this.id.value = id ?? this.id.value;
    this.courtPhoneNumber.value =
        courtPhoneNumber ?? this.courtPhoneNumber.value;
    this.courtEmailAddress.value =
        courtEmailAddress ?? this.courtEmailAddress.value;
    this.courtDescription.value =
        courtDescription ?? this.courtDescription.value;
    this.openingTime.value = openingTime != null
        ? '${openingTime.hour}:${openingTime.minute}'
        : this.openingTime.value;
    this.closingTime.value = closingTime != null
        ? '${closingTime.hour}:${closingTime.minute}'
        : this.closingTime.value;
    this.courtLocation.value = courtLocation ?? this.courtLocation.value;
    this.images.value = images ?? this.images.value;
    this.ownerPhoto.value = ownerPhoto ?? this.ownerPhoto.value;
    this.ownerFullName.value = ownerFullName ?? this.ownerFullName.value;
    this.ownerPhoneNumber.value =
        ownerPhoneNumber ?? this.ownerPhoneNumber.value;
    this.ownerEmailAddress.value =
        ownerEmailAddress ?? this.ownerEmailAddress.value;
    this.isOwner.value = isOwner ?? this.isOwner.value;
    this.isRegistered.value = isRegistered ?? this.isRegistered.value;
  }
}
