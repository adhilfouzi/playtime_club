import 'dart:developer';

import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/model/backend/repositories/user/transaction_repositories.dart';
import 'package:owners_side_of_turf_booking/model/data_model/transaction_model.dart';

class TransactionController extends GetxController {
  final _isLoading = false.obs;
  final _transaction = <TransactionModel>[].obs;
  final _errorMessage = RxString('');
  final _totalAmount = 0.0.obs;
  final _startDate = DateTime(2024).obs;
  final _endDate = DateTime.now().obs;
  final _revenueAsPerDay = 0.0.obs;

  bool get isLoading => _isLoading.value;
  List<TransactionModel> get transaction => _transaction.toList();
  String get errorMessage => _errorMessage.value;
  double get totalAmount => _totalAmount.value;
  Rx<DateTime> get startDate => _startDate;
  Rx<DateTime> get endDate => _endDate;
  double get revenueAsPerDay => _revenueAsPerDay.value;

  @override
  void onInit() {
    super.onInit();
    fetchTransaction();
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
      _revenueAsPerDay.value = _totalAmount.value;
      _transaction
          .sort((a, b) => a.transactionDate.compareTo(b.transactionDate));
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
