import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view_model/course/slot_request_controller.dart';
import 'utils/booking_list_item.dart';

class Reservation extends StatelessWidget {
  const Reservation({super.key});

  @override
  Widget build(BuildContext context) {
    final SlotRequestController controller = Get.find();

    Future<void> refresh() async {
      await controller.fetchBookingRequests();
    }

    return Scaffold(
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
              if (controller.approvedBookings.isEmpty) {
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 200,
                      alignment: Alignment.center,
                      child: const Text("No bookings available"),
                    ),
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    itemCount: controller.approvedBookings.length,
                    itemBuilder: (context, index) {
                      return BookingListItem(index: index);
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
