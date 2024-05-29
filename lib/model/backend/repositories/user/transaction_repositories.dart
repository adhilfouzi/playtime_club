import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data_model/transaction_model.dart';
import '../authentication/firebase_authentication.dart';
import '../authentication/firebase_exceptionhandler.dart';

class TransactionRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<TransactionModel>> fetchTransaction() async {
    try {
      final authUser = AuthenticationRepository().authUser;
      if (authUser == null) {
        throw Exception('User not authenticated');
      }

      var transactionSnapshot = await _db
          .collection('Owner')
          .doc(authUser.uid)
          .collection('transactions')
          .get();

      List<TransactionModel> transactionList = transactionSnapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data(), doc.id))
          .toList();

      log("Total Transaction Count: ${transactionList.length}");
      return transactionList;
    } catch (e) {
      log("Error fetching transactions: $e");
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Save Transaction data to Firestore
  Future<void> saveTransactionRecord(TransactionModel transaction) async {
    try {
      final authUser = AuthenticationRepository().authUser;
      if (authUser == null) {
        throw Exception('User not authenticated');
      }

      await _db
          .collection("Owner")
          .doc(authUser.uid)
          .collection('transactions')
          .add(transaction.toJson());

      log("Transaction record saved successfully");
    } catch (e) {
      log("Error saving transaction record: $e");
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Update Transaction status in Firestore
  Future<void> updateTransactionStatus(
      String transactionId, String newStatus) async {
    try {
      final authUser = AuthenticationRepository().authUser;
      if (authUser == null) {
        throw Exception('User not authenticated');
      }

      await _db
          .collection("Owner")
          .doc(authUser.uid)
          .collection('transactions')
          .doc(transactionId)
          .update({'status': newStatus});

      log("Transaction status updated successfully: $newStatus");
    } catch (e) {
      log("Error updating transaction status: $e");
      throw ExceptionHandler.handleException(e);
    }
  }
}
