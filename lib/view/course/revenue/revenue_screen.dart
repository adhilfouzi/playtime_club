import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../view_model/course/transaction_controller.dart';
import 'utils/date_filter.dart';
import 'utils/total_revenue_section.dart';
import 'utils/transaction_list.dart';

class Revenue extends StatefulWidget {
  const Revenue({super.key});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  DateTime? _startDate;
  DateTime? _endDate;
  double revenueAsPerDay = 0;

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.find();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    // Group bookings by date
    Map<String, List<dynamic>> bookingsByDate = {};
    revenueAsPerDay = 0; // Reset the revenue for the selected period

    final bookings = controller.transaction.where((booking) {
      if (_startDate != null && _endDate != null) {
        return booking.transactionDate.isAfter(_startDate!) &&
            booking.transactionDate
                .isBefore(_endDate!.add(const Duration(days: 1)));
      }
      return true;
    }).toList();

    for (var booking in bookings) {
      final dates = booking.transactionDate;
      String date = DateFormat('yyyy-MM-dd')
          .format(dates); // Changed to just yyyy-MM-dd for key
      if (!bookingsByDate.containsKey(date)) {
        bookingsByDate[date] = [];
      }
      bookingsByDate[date]!.add(booking);
      revenueAsPerDay += booking.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transactions",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalRevenueSection(
              revenueAsPerDay: revenueAsPerDay,
              totalAmount: controller.totalAmount,
            ),
            SizedBox(height: height * 0.02),
            DateFilter(
              startDate: _startDate,
              endDate: _endDate,
              onDateRangeSelected: (DateTimeRange? picked) {
                if (picked != null) {
                  setState(() {
                    _startDate = picked.start;
                    _endDate = picked.end;
                    revenueAsPerDay =
                        0; // Reset revenue when date range is changed
                  });
                }
              },
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: bookingsByDate.isNotEmpty
                  ? TransactionList(bookingsByDate: bookingsByDate)
                  : const Center(
                      child: Text("No Transactions Available"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
