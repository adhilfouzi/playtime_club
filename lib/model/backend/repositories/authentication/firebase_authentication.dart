import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../view/course/head/bottom_navigationbar_widget.dart';
import '../../../../view/onboarding/signup/screen/signup_court_details/signup_court_details_screen.dart';
import '../../../../view_model/course/usermodel_controller.dart';
import '../../../../view_model/onboarding/signup/signup_controller.dart';
import '../user/user_repositories.dart';
import 'firebase_exceptionhandler.dart';

const logs = 'action';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  UserController userController = Get.find();

  Future<UserCredential> registerWithEmailAndPassword(String email) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: "123456"
          //  DateTime.now().toString()
          );
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential auth = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(auth.user!.uid);
      UserRepository userRepository = Get.find();
      final user = await userRepository.fetchUserdetails(auth.user!.uid);

      UserController userController = Get.find();
      userController.user(user);
      if (user.isOwner) {
        Get.put(SignupController());
        if (user.isRegistered) {
          await prefs.setStringList(logs, <String>[email, password]);
          Get.offAll(() => const MyBottomNavigationBar());
        } else {
          Get.offAll(() => SignupCourtDetailsScreen());
        }
        return true;
      } else {
        // Handle error
        log("Some error happened");
        return false;
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  // Sign out the current user using Firebase authentication
  Future<void> userLogout() async {
    try {
      log(_auth.currentUser!.uid.toString());
      await _auth.signOut();
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
