import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../view_model/course/slot_request_controller.dart';
import '../../../model/data_model/booking_model.dart';
import 'utils/booking_list_item.dart';

class Reservation extends StatelessWidget {
  const Reservation({Key? key});

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
                // Group bookings by date
                Map<DateTime, List<BookingModel>> groupedBookings =
                    groupBookingsByDate(controller.approvedBookings);

                return RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    itemCount: groupedBookings.length,
                    itemBuilder: (context, index) {
                      var date = groupedBookings.keys.toList()[index];
                      var bookings = groupedBookings[date];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Text(
                              DateFormat('dd-MMM-yy').format(date),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bookings!.length,
                            itemBuilder: (context, index) {
                              return BookingListItem(
                                index: index,
                              );
                            },
                          ),
                          const Divider(),
                        ],
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

  // Function to group bookings by date
  Map<DateTime, List<BookingModel>> groupBookingsByDate(
      List<BookingModel> bookings) {
    Map<DateTime, List<BookingModel>> groupedBookings = {};
    for (var booking in bookings) {
      DateTime date = DateTime(booking.startTime.year, booking.startTime.month,
          booking.startTime.day);
      if (groupedBookings.containsKey(date)) {
        groupedBookings[date]!.add(booking);
      } else {
        groupedBookings[date] = [booking];
      }
    }
    return groupedBookings;
  }
}
