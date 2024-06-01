import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:owners_side_of_turf_booking/model/backend/repositories/user/transaction_repositories.dart';
import 'package:owners_side_of_turf_booking/model/data_model/transaction_model.dart';

class TransactionController extends GetxController {
  final _isLoading = false.obs;
  final _isLoadingHome = false.obs;
  final _transaction = <TransactionModel>[].obs;
  final _errorMessage = RxString('');
  final _totalAmount = 0.0.obs;
  final _startDate = DateTime(2024).obs;
  final _endDate = DateTime.now().obs;
  final _revenueAsPerDay = 0.0.obs;

  bool get isLoading => _isLoading.value;
  bool get isHomeLoading => _isLoadingHome.value;
  List<TransactionModel> get transaction => _transaction.toList();
  String get errorMessage => _errorMessage.value;
  double get totalAmount => _totalAmount.value;
  DateTime get startDate => _startDate.value;
  DateTime get endDate => _endDate.value;
  double get revenueAsPerDay => _revenueAsPerDay.value;
  Map<String, List<TransactionModel>> get bookingsByDate => _bookingsByDate();

  @override
  void onInit() {
    super.onInit();
    fetchTransaction();
  }

  Future<void> refreshHomescreen() async {
    try {
      _isLoadingHome.value = true;

      final transaction = await TransactionRepository().fetchTransaction();

      for (var element in transaction) {
        log('fetch Transaction in Transaction Controller');
        _totalAmount.value += element.amount;
        _transaction.add(element);
      }

      _transaction
          .sort((a, b) => a.transactionDate.compareTo(b.transactionDate));

      _calculateRevenue();
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoadingHome.value = false;
    }
  }

  Future<void> fetchTransaction() async {
    _isLoading.value = true;
    _errorMessage.value = '';
    _transaction.clear();
    _totalAmount.value = 0.0;
    try {
      final transaction = await TransactionRepository().fetchTransaction();
      for (var element in transaction) {
        log('fetch Transaction in Transaction Controller');
        _totalAmount.value += element.amount;
        _transaction.add(element);
      }
      _transaction
          .sort((a, b) => a.transactionDate.compareTo(b.transactionDate));
      _calculateRevenue();
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  void updateDateRange(DateTime start, DateTime end) {
    _startDate.value = start;
    _endDate.value = end;
    log(start.toIso8601String());
    log(end.toIso8601String());
    _calculateRevenue();
  }

  void _calculateRevenue() {
    _revenueAsPerDay.value = 0.0;
    for (var booking in _transaction) {
      if (booking.transactionDate.isAfter(_startDate.value) &&
          booking.transactionDate
              .isBefore(_endDate.value.add(const Duration(days: 1)))) {
        _revenueAsPerDay.value += booking.amount;
      }
    }
  }

  Map<String, List<TransactionModel>> _bookingsByDate() {
    Map<String, List<TransactionModel>> bookingsByDate = {};
    for (var booking in _transaction) {
      if (booking.transactionDate.isAfter(_startDate.value) &&
          booking.transactionDate
              .isBefore(_endDate.value.add(const Duration(days: 1)))) {
        final dates = booking.transactionDate;
        String date = DateFormat('yyyy-MM-dd').format(dates);
        if (!bookingsByDate.containsKey(date)) {
          bookingsByDate[date] = [];
        }
        bookingsByDate[date]!.add(booking);
      }
    }
    return bookingsByDate;
  }

  // // Group bookings by date
  // Map<String, List<dynamic>> bookingsByDate = {};
  // revenueAsPerDay = 0; // Reset the revenue for the selected period

  // final bookings = controller.transaction.where((booking) {
  //   if (_startDate != null && _endDate != null) {
  //     return booking.transactionDate.isAfter(_startDate!) &&
  //         booking.transactionDate
  //             .isBefore(_endDate!.add(const Duration(days: 1)));
  //   }
  //   return true;
  // }).toList();

  // for (var booking in bookings) {
  //   final dates = booking.transactionDate;
  //   String date = DateFormat('yyyy-MM-dd')
  //       .format(dates); // Changed to just yyyy-MM-dd for key
  //   if (!bookingsByDate.containsKey(date)) {
  //     bookingsByDate[date] = [];
  //   }
  //   bookingsByDate[date]!.add(booking);
  //   revenueAsPerDay += booking.amount;
  // }
}
