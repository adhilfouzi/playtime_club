import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view/course/home/utils/status_chart.dart';
import '../../../view_model/course/slot_request_controller.dart';
import 'utils/home_appbar.dart';
import 'utils/booking_stats_widget.dart';
import 'utils/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Get.put(SlotReservationController());

    return Scaffold(
      appBar: const HomeScreenAppBar(),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderWidget(),
              SizedBox(height: height * 0.02),
              SizedBox(
                height:
                    height * 0.4, // Provide a fixed height or adjust as needed
                child: StatusChart(),
              ),
              const BookingStatsWidget(),
              // Additional widgets can be added here
            ],
          ),
        ),
      ),
    );
  }
}
