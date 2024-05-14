import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_model/course/slot_request_controller.dart';
import 'view_booked_details.dart';

class SlotRequest extends StatelessWidget {
  const SlotRequest({super.key});

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
          "Slot Request",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "User",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  "Date & Time",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  "Action",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
            const Divider(
              color: Colors.black87,
              thickness: 2,
              height: 15,
            ),
            Expanded(
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
                    if (controller.requestedBookings.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: refresh,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            height: MediaQuery.of(context).size.height - 200,
                            alignment: Alignment.center,
                            child: const Text("No request available"),
                          ),
                        ),
                      );
                    } else {
                      return RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                          itemCount: controller.requestedBookings.length,
                          itemBuilder: (context, index) {
                            final request = controller.requestedBookings[index];
                            return InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ViewBookingDetails(
                                      booking:
                                          controller.requestedBookings[index],
                                    ); // Show the booking details dialog
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(request.username,
                                      style: const TextStyle(fontSize: 14)),
                                  Text(
                                      controller
                                          .dateTimeToString(request.startTime),
                                      style: const TextStyle(fontSize: 14)),
                                  PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.more_vert,
                                    ),
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'approved',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.done_all,
                                              color: Colors.green,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Approve',
                                              style: TextStyle(fontSize: 13),
                                            )
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'canceled',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Cancel",
                                              style: TextStyle(fontSize: 13),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                    onSelected: (String value) {
                                      switch (value) {
                                        case 'approved':
                                          controller.updateBookingStatus(
                                              request.id!, "approved");
                                          break;
                                        case 'canceled':
                                          controller.updateBookingStatus(
                                              request.id!, "canceled");
                                          break;
                                      }
                                    },
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
