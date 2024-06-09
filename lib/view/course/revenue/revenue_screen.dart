import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/course/transaction_controller.dart';
import '../head/bottom_navigationbar_widget.dart';
import 'utils/date_filter.dart';
import 'utils/total_revenue_section.dart';
import 'utils/transaction_list.dart';

class Revenue extends StatelessWidget {
  const Revenue({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.find<TransactionController>();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Get.offAll(fullscreenDialog: true, const MyBottomNavigationBar());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Transactions",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  controller.fetchTransaction();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.01),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Observe total revenue and revenue per day
                TotalRevenueSection(
                  revenueAsPerDay: controller.revenueAsPerDay,
                  totalAmount: controller.totalAmount,
                ),
                SizedBox(height: height * 0.02),
                // Observe date filter
                DateFilter(
                  isRevenue: true,
                  startDate: controller.startDate,
                  endDate: controller.endDate,
                  onDateRangeSelected: (DateTimeRange? picked) {
                    if (picked != null) {
                      controller.updateDateRange(picked.start, picked.end);
                    }
                  },
                ),
                SizedBox(height: height * 0.02),
                // Observe bookings by date
                Expanded(
                  child: controller.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: height * 0.6, // Adjust height as needed
                            child: controller.bookingsByDate.isNotEmpty
                                ? TransactionList(
                                    bookingsByDate: controller.bookingsByDate)
                                : const Center(
                                    child: Text("No Transactions Available")),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
