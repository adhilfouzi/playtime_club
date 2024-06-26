import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../view/course/head/bottom_navigationbar_widget.dart';
import '../../../../view/onboarding/signup/screen/signup_court_details/signup_court_details_screen.dart';
import '../../../../view_model/course/slot_request_controller.dart';
import '../../../../view_model/course/transaction_controller.dart';
import '../../../../view_model/course/usermodel_controller.dart';
import '../user/user_repositories.dart';
import 'firebase_exceptionhandler.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  // Controllers
  UserController userController = Get.find();

  // Register with email and password
  Future<UserCredential> registerWithEmailAndPassword(String email) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: DateTime.now().toString(),
      );
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  // Sign in with email and password
  Future<bool> signInWithEmailAndPassword(
      String email, String password, bool isLogin) async {
    try {
      late User? userAuth;

      if (isLogin) {
        userAuth = FirebaseAuth.instance.currentUser;
      } else {
        UserCredential auth = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        userAuth = auth.user;
        log(auth.user!.uid);
      }

      UserRepository userRepository = Get.find();
      final user = await userRepository.fetchUserDetails(userAuth!.uid);

      UserController userController = Get.find();
      userController.user(user);

      // Fetch transaction and reservation details
      var transaction = Get.find<TransactionController>();
      var reservation = Get.find<SlotReservationController>();
      transaction.fetchTransaction();
      reservation.fetchBookingRequests();

      if (user.isOwner) {
        if (user.isRegistered) {
          Get.offAll(() => const MyBottomNavigationBar());
        } else {
          Get.offAll(() => SignupCourtDetailsScreen());
        }
        return true;
      } else {
        log("Some error happened");
        return false;
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  // Sign out the current user
  Future<void> userLogout() async {
    try {
      log(_auth.currentUser!.uid.toString());
      await _auth.signOut();
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
