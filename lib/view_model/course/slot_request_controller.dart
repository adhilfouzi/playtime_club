import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/backend/repositories/user/booking_repositories.dart';
import '../../model/data_model/booking_model.dart';

class SlotReservationController extends GetxController {
  final BookingRepository _bookingRepository = BookingRepository();

  // Private data members
  final _requestedBookings = <BookingModel>[].obs;
  final _approvedBookings = <BookingModel>[].obs;
  final _filteredBookings = <BookingModel>[].obs;
  final _groupedBookings = <DateTime, List<BookingModel>>{}.obs;
  final _isLoading = false.obs;
  final _totalBooking = 0.obs;
  final _totalTransaction = 0.0.obs;
  final _errorMessage = RxString('');
  final _startDate = DateTime.now().obs;
  final _endDate = DateTime.now().add(const Duration(days: 7)).obs;

  // Getters for private data
  List<BookingModel> get requestedBookings => _requestedBookings.toList();
  List<BookingModel> get approvedBookings => _approvedBookings.toList();
  List<BookingModel> get filteredBookings => _filteredBookings.toList();
  Map<DateTime, List<BookingModel>> get groupedBookings => _groupedBookings;
  bool get isLoading => _isLoading.value;
  int get totalBooking => _totalBooking.value;
  double get totalTransaction => _totalTransaction.value;
  String get errorMessage => _errorMessage.value;
  DateTime get startDate => _startDate.value;
  DateTime get endDate => _endDate.value;

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
      _filteredBookings.clear();
      _groupedBookings.clear();
      // Fetch booking requests from the repository
      final bookings = await _bookingRepository.fetchBookingRequests();
      _totalBooking.value = bookings.length;

      for (var booking in bookings) {
        _totalTransaction.value += booking.price;
        if (booking.status == 'approved') {
          _approvedBookings.add(booking);
        } else if (booking.status == 'pending') {
          _requestedBookings.add(booking);
        }
      }
      _approvedBookings.sort((a, b) => a.startTime.compareTo(b.startTime));
      _requestedBookings.sort((a, b) => a.startTime.compareTo(b.startTime));
      filterBookings();
    } catch (e) {
      _errorMessage.value = 'Error: $e';
      log('Error fetching booking requests: $e'); // Log the error
    } finally {
      _isLoading.value = false; // Set loading to false
    }
  }

  void filterBookings() {
    _filteredBookings.value = _approvedBookings
        .where((booking) =>
            booking.startTime.isAfter(_startDate.value) &&
            booking.startTime
                .isBefore(_endDate.value.add(const Duration(days: 1))))
        .toList();
    groupBookingsByDate();
  }

  void updateDateRange(DateTime start, DateTime end) {
    _startDate.value = start;
    _endDate.value = end;
    filterBookings();
  }

  /// Function to group bookings by date
  void groupBookingsByDate() {
    _groupedBookings.clear();
    for (var booking in _filteredBookings) {
      DateTime date = DateTime(booking.startTime.year, booking.startTime.month,
          booking.startTime.day);
      if (_groupedBookings.containsKey(date)) {
        _groupedBookings[date]!.add(booking);
      } else {
        _groupedBookings[date] = [booking];
      }
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
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm a');
    String formattedDateTime = dateFormat.format(dateTime);
    return formattedDateTime;
  }
}
