import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ExceptionHandler {
  static String handleException(dynamic e) {
    log(e.toString());
    if (e is FirebaseAuthException) {
      log(e.toString());
      return _handleFirebaseAuthException(e);
    } else if (e is FirebaseException) {
      return 'Firebase Exception: ${e.message}';
    } else if (e is FormatException) {
      return 'Format Exception: ${e.message}';
    } else if (e is PlatformException) {
      return 'Platform Exception: ${e.message}';
    } else {
      return 'An unknown exception occurred.';
    }
  }

  static String _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your internet connection.';
      case 'quota-exceeded':
        return 'The Firebase quota for this operation has been exceeded.';
      case 'provider-already-linked':
        return 'The user already has this provider linked to their account.';
      case 'credential-already-in-use':
        return 'This credential is already associated with another user account.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please reauthenticate and try again.';
      case 'user-mismatch':
        return 'The provided credential does not match the user associated with the current session.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check and try again.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code';
      default:
        return 'Firebase Auth Exception: ${e.message}';
    }
  }
}
