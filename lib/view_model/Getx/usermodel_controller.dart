import 'dart:developer';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/model/backend/repositories/authentication/firebase_authentication.dart';

import '../../model/backend/repositories/user/user_repositories.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
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
  final RxBool isOwner = false.obs;
  final RxBool isRegistered = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   getUserRecord();
  // }

  Future<void> getUserRecord() async {
    try {
      final authUser = AuthenticationRepository().authUser;

      final user = await userRepository.getUserById((authUser!.uid));

      updateValues(
        id: AuthenticationRepository().authUser!.uid,
        courtName: user.courtName,
        courtPhoneNumber: user.courtPhoneNumber,
        courtEmailAddress: user.courtEmailAddress,
        courtDescription: user.courtDescription,
        openingTime: user.openingTime,
        closingTime: user.closingTime,
        courtLocation: user.courtLocation,
        images: user.images,
        ownerPhoto: user.ownerPhoto,
        ownerFullName: user.ownerFullName,
        ownerPhoneNumber: user.ownerPhoneNumber,
        ownerEmailAddress: user.ownerEmailAddress,
        isOwner: user.isOwner,
        isRegistered: user.isRegistered,
      );
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
    String? openingTime,
    String? closingTime,
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
    this.openingTime.value = openingTime ?? this.openingTime.value;
    this.closingTime.value = closingTime ?? this.closingTime.value;
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
