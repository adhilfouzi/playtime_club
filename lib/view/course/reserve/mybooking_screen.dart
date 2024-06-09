import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../view_model/course/slot_request_controller.dart';
import '../head/bottom_navigationbar_widget.dart';
import '../revenue/utils/date_filter.dart';
import 'utils/empty_booking_list.dart';
import 'utils/populated_booking_list.dart';

class Reservation extends StatelessWidget {
  const Reservation({super.key});

  @override
  Widget build(BuildContext context) {
    final SlotReservationController controller = Get.find();

    Future<void> refresh() async {
      await controller.fetchBookingRequests();
    }

    Widget buildBookingList() {
      return controller.groupedBookings.isEmpty
          ? EmptyBookingList(refresh: refresh)
          : PopulatedBookingList(controller: controller);
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Get.offAll(fullscreenDialog: true, const MyBottomNavigationBar());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Slot Reservation",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage));
              } else {
                return Column(
                  children: [
                    DateFilter(
                      isRevenue: false,
                      startDate: controller.startDate,
                      endDate: controller.endDate,
                      onDateRangeSelected: (DateTimeRange? picked) {
                        if (picked != null) {
                          controller.updateDateRange(picked.start, picked.end);
                        }
                      },
                    ),
                    Expanded(child: buildBookingList()),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
