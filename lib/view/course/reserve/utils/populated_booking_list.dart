import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/data_model/booking_model.dart';
import '../../../../view_model/course/slot_request_controller.dart';
import 'booking_list_item.dart';

class PopulatedBookingList extends StatelessWidget {
  final SlotReservationController controller;

  const PopulatedBookingList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.fetchBookingRequests,
      child: ListView.builder(
        itemCount: controller.groupedBookings.length,
        itemBuilder: (context, index) {
          DateTime date = controller.groupedBookings.keys.toList()[index];
          List<BookingModel> bookings = controller.groupedBookings[date]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  var booking = bookings[index];
                  return BookingListItem(booking: booking);
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
