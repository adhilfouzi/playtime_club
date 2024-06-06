import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view/course/home/utils/status_chart.dart';
import '../../../view_model/course/slot_request_controller.dart';
import '../../../view_model/course/transaction_controller.dart';
import 'utils/home_appbar.dart';
import 'utils/booking_stats_widget.dart';
import 'utils/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Ensure only one instance is created and used
    Get.put(SlotReservationController(), permanent: true);
    final controller = Get.put(TransactionController(), permanent: true);

    Future<void> refresh() async {
      await controller.refreshHomescreen();
    }

    return Scaffold(
      appBar: const HomeScreenAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Obx(() {
          if (controller.isHomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeaderWidget(),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    height: height *
                        0.4, // Provide a fixed height or adjust as needed
                    child: const StatusChart(),
                  ),
                  const BookingStatsWidget(),
                  // Additional widgets can be added here
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
