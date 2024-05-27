import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../view_model/course/slot_request_controller.dart';
import 'view_booking_screen.dart';

class BookingListItem extends StatelessWidget {
  final int index;
  const BookingListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final SlotRequestController controller = Get.find();
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
                  Get.to(() => ViewBookingDetailsScreen(booking: request));
                },
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/image/profile.png'),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('dd-MMM-yy').format(request.startTime),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${DateFormat('hh:mm aa').format(request.startTime)} to ${DateFormat('hh:mm aa').format(request.endTime)}',
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
  }
}
