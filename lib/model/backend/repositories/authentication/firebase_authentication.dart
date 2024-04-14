import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_exceptionhandler.dart';

class AuthenticationRepository {
  // static AuthenticationRepository get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> registerWithEmailAndPassword(String email) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: DateTime.now().toString());
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
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
