import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data_model/booking_model.dart';
import '../authentication/firebase_authentication.dart';
import '../authentication/firebase_exceptionhandler.dart';

class BookingRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BookingModel>> fetchBookingRequests() async {
    try {
      var bookingSnapshot = await _db
          .collection('Owner')
          .doc(AuthenticationRepository().authUser!.uid)
          .collection('bookings')
          .get();

      List<BookingModel> bookingList = [];
      for (var doc in bookingSnapshot.docs) {
        Map<String, dynamic> turfData = doc.data();
        String bookingId = doc.id; // Retrieve the document ID
        bookingList.add(BookingModel.fromJson(turfData, bookingId));
      }

      log("Total booking Request: ${bookingList.length}");
      return bookingList;
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Save booking data to Firestore
  Future<void> saveBookingRecord(BookingModel booking) async {
    try {
      await _db
          .collection("Owner")
          .doc(AuthenticationRepository().authUser!.uid)
          .collection('bookings')
          .add(booking.toJson());
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Update booking status in Firestore
  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      await _db
          .collection("Owner")
          .doc(AuthenticationRepository().authUser!.uid)
          .collection('bookings')
          .doc(bookingId)
          .update({'status': newStatus});
      log("Booking status updated successfully: $newStatus"); // Log success
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
