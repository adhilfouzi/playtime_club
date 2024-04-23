import 'dart:developer';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/model/backend/repositories/authentication/firebase_authentication.dart';
import 'package:owners_side_of_turf_booking/model/data_model/user_request_model.dart';

import '../../model/backend/repositories/user/user_repositories.dart';

class UserController extends GetxController {
  // static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.emptyUserModel().obs;

  @override
  void onReady() {
    getUserRecord();
    super.onReady();
  }

  Future<void> getUserRecord() async {
    try {
      var authenticationRepository = Get.put(AuthenticationRepository());

      final authUser = authenticationRepository.authUser;
      var userRepository = Get.put(UserRepository());

      if (authUser != null) {
        final userd = await userRepository.getUserById();
        user(userd);
      }
    } catch (e) {
      user(UserModel.emptyUserModel());
      log("getUserRecord failed");
      log(e.toString());
    }
  }
}
