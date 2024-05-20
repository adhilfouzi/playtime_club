import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepository {
  // final _storage = FirebaseStorage.instance;

  static Future<String> uploadImages(File file, bool isProfile) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.email;
      final fileName = file.path.split("/").last;
      final time = DateTime.now().millisecondsSinceEpoch;
      // Create a reference to the location you want to upload to in Firebase
      // Storage
      late Reference reference;
      if (isProfile) {
        reference = FirebaseStorage.instance
            .ref()
            .child('owner_profile/$userId/$time-$fileName');
      } else {
        reference = FirebaseStorage.instance
            .ref()
            .child('turf_images/$userId/$time-$fileName');
      }
      // Upload the file to Firebase Storage
      UploadTask uploadTask = reference.putFile(file);

      // Wait for the upload to complete and return the download URL
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image to Firebase Storage: $e');
    }
  }
}
