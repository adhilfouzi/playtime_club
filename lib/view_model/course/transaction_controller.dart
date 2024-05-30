import 'dart:developer';

import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/model/backend/repositories/user/transaction_repositories.dart';
import 'package:owners_side_of_turf_booking/model/data_model/transaction_model.dart';

class TransactionController extends GetxController {
  // Private data members
  final _isLoading = false.obs;
  final _transaction = <TransactionModel>[].obs;
  final _errorMessage = RxString('');
  final _totalAmount = 0.0.obs;

  // Private data members
  bool get isLoading => _isLoading.value;
  List<TransactionModel> get transaction => _transaction.toList();
  String get errorMessage => _errorMessage.value;
  double get totalAmount => _totalAmount.value;

  @override
  void onInit() {
    super.onInit();
    fetchTransaction();
  }

  Future<void> fetchTransaction() async {
    _isLoading.value = true; // Set loading to true
    _errorMessage.value = ''; // Clear error message
    _transaction.clear();
    try {
      final transaction = await TransactionRepository().fetchTransaction();
      for (var element in transaction) {
        log('fetch Transaction in Transaction Controller');
        _totalAmount.value += element.amount;
        _transaction.add(element);
      }

      _transaction
          .sort((a, b) => a.transactionDate.compareTo(b.transactionDate));
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}
