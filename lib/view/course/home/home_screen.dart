import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/course/slot_request_controller.dart';
import 'home_appbar.dart';
import 'utils/booking_stats_widget.dart';
import 'utils/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Get.put(SlotRequestController());

    return Scaffold(
      appBar: const HomeScreenAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderWidget(width: width, height: height),
            SizedBox(height: height * 0.02),
            BookingStatsWidget(width: width, height: height),
            // Additional widgets can be added here
          ],
        ),
      ),
    );
  }
}
