import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view_model/Getx/usermodel_controller.dart';

import '../user/user_repositories.dart';
import 'firebase_exceptionhandler.dart';

class AuthenticationRepository {
  static AuthenticationRepository get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  var userController = UserController.instance;

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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await UserRepository().getUserById(userCredential.user!.uid);

      userController.updateValues(
          id: userCredential.user!.uid,
          closingTime: user.closingTime,
          courtDescription: user.courtDescription,
          courtEmailAddress: user.courtEmailAddress,
          courtLocation: user.courtLocation,
          courtName: user.courtName,
          courtPhoneNumber: user.courtPhoneNumber,
          images: user.images,
          isOwner: user.isOwner,
          isRegistered: user.isRegistered,
          openingTime: user.openingTime,
          ownerEmailAddress: user.ownerEmailAddress,
          ownerFullName: user.ownerFullName,
          ownerPhoneNumber: user.ownerPhoneNumber,
          ownerPhoto: user.ownerPhoto);
      return user.isOwner;
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
}
