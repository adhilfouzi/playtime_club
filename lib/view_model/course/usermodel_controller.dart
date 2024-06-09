import 'dart:developer';
import 'package:get/get.dart';
import '../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../model/backend/repositories/user/user_repositories.dart';
import '../../model/data_model/owner_model.dart';

class UserController extends GetxController {
  // static UserController get instance => Get.find();
  Rx<OwnerModel> user = OwnerModel.emptyOwnerModel().obs;

  @override
  void onReady() {
    getUserRecord();
    super.onReady();
  }

  Future<void> getUserRecord() async {
    try {
      var authenticationRepository = Get.put(AuthenticationRepository());

      final authUser = authenticationRepository.authUser;
      var userRepository = Get.find<UserRepository>();

      if (authUser != null) {
        final userd = await userRepository.getUserById();
        user(userd);
      }
    } catch (e) {
      user(OwnerModel.emptyOwnerModel());
      log("getUserRecord failed");
      log(e.toString());
    }
  }
}
