import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_model/course/transaction_controller.dart';
import 'utils/date_filter.dart';
import 'utils/total_revenue_section.dart';
import 'utils/transaction_list.dart';

class Revenue extends StatelessWidget {
  const Revenue({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.find();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

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
            Obx(() => TotalRevenueSection(
                  revenueAsPerDay: controller.revenueAsPerDay,
                  totalAmount: controller.totalAmount,
                )),
            SizedBox(height: height * 0.02),
            Obx(() => DateFilter(
                  startDate: controller.startDate,
                  endDate: controller.endDate,
                  onDateRangeSelected: (DateTimeRange? picked) {
                    if (picked != null) {
                      controller.updateDateRange(picked.start, picked.end);
                    }
                  },
                )),
            SizedBox(height: height * 0.02),
            Expanded(
              child: Obx(() {
                final bookingsByDate = controller.bookingsByDate;
                return bookingsByDate.isNotEmpty
                    ? TransactionList(bookingsByDate: bookingsByDate)
                    : const Center(
                        child: Text("No Transactions Available"),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
