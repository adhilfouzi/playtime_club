import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/backend/repositories/user/booking_repositories.dart';
import '../../model/data_model/booking_model.dart';

class SlotRequestController extends GetxController {
  final BookingRepository _bookingRepository = BookingRepository();

  // Private data members
  final _requestedBookings = <BookingModel>[].obs;
  final _approvedBookings = <BookingModel>[].obs;
  final _isLoading = false.obs;
  final _errorMessage = RxString('');

  // Getters for private data
  List<BookingModel> get requestedBookings => _requestedBookings.toList();
  List<BookingModel> get approvedBookings => _approvedBookings.toList();
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    fetchBookingRequests();
    super.onInit();
  }

  /// Function to fetch booking requests
  Future<void> fetchBookingRequests() async {
    try {
      _isLoading.value = true; // Set loading to true
      _errorMessage.value = ''; // Clear error message
      _approvedBookings.clear();
      _requestedBookings.clear();
      // Fetch booking requests from the repository
      final bookings = await _bookingRepository.fetchBookingRequests();
      for (var booking in bookings) {
        if (booking.status == 'approved') {
          _approvedBookings.add(booking);
        } else if (booking.status == 'pending') {
          _requestedBookings.add(booking);
        }
      }
    } catch (e) {
      _errorMessage.value =
          'Error fetching booking requests: $e'; // Set error message
      log('Error fetching booking requests: $e'); // Log the error
    } finally {
      _isLoading.value = false; // Set loading to false
    }
  }

  /// Function to update the status of a booking request
  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      _isLoading.value = true; // Set loading to true
      _errorMessage.value = ''; // Clear error message
      // Update the status of the booking request in the repository
      await _bookingRepository.updateBookingStatus(bookingId, newStatus);
      log('Booking status updated successfully: $newStatus'); // Log success
      await fetchBookingRequests(); // Fetch updated booking requests
    } catch (e) {
      _errorMessage.value =
          'Error updating booking request status: $e'; // Set error message
      log('Error updating booking request status: $e'); // Log the error
    } finally {
      _isLoading.value = false; // Set loading to false
    }
  }

  String dateTimeToString(DateTime dateTime) {
    // Using the DateFormat class from the intl package to format the date and time
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDateTime = dateFormat.format(dateTime);
    return formattedDateTime;
  }
}
