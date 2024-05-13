import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../view_model/course/slot_request_controller.dart';
import '../slot_request/view_booked_details.dart';

class Reservation extends StatelessWidget {
  const Reservation({super.key});

  @override
  Widget build(BuildContext context) {
    final SlotRequestController controller = Get.find();
    Future<void> refresh() async {
      // Fetch booking requests again when refreshing
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
              // Show loading indicator
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.errorMessage.isNotEmpty) {
              // Show error message
              return Center(
                child: Text(controller.errorMessage),
              );
            } else {
              // Show list of booking requests
              if (controller.approvedBookings.isEmpty) {
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 200,
                      alignment: Alignment.center,
                      child: Text("No bookings available"),
                    ),
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    itemCount: controller.approvedBookings.length,
                    itemBuilder: (context, index) {
                      final request = controller.approvedBookings[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ViewBookingDetails(
                                          booking: controller
                                              .approvedBookings[index],
                                        ); // Show the booking details dialog
                                      },
                                    );
                                  },
                                  leading: const CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/image/profile.png'),
                                  ),
                                  title: Text(
                                    request.username,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Phone: ${request.userNumber}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          DateFormat('dd-MMM-yyyy')
                                              .format(request.startTime),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${DateFormat('hh:mm a').format(request.startTime)} to ${DateFormat('hh:mm a').format(request.endTime)}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
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
