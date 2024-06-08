import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owners_side_of_turf_booking/utils/appbar/titleonly_appbar.dart';
import 'package:owners_side_of_turf_booking/utils/portion/url.dart';
import '../../../model/data_model/booking_model.dart';
import '../../../utils/portion/button.dart';
import '../reserve/utils/detail_item.dart';

class ViewBookingDetailsScreen extends StatelessWidget {
  final BookingModel booking;

  const ViewBookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleOnlyAppBar(
        title: "Booking Details",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailItem(
                  icon: Icons.person,
                  title: "Name",
                  value: booking.username,
                ),
                const SizedBox(height: 16),
                DetailItem(
                  icon: Icons.phone,
                  title: "Phone",
                  value: booking.userNumber,
                  onTap: () => Url.makePhoneCall(booking.userNumber),
                ),
                const SizedBox(height: 16),
                DetailItem(
                  icon: Icons.email,
                  title: "Email",
                  value: booking.userEmail,
                ),
                const Divider(height: 32),
                DetailItem(
                  icon: Icons.calendar_today,
                  title: "Booking Date",
                  value: DateFormat('dd-MMM-yy').format(booking.startTime),
                ),
                const SizedBox(height: 16),
                DetailItem(
                  icon: Icons.access_time,
                  title: "Time",
                  value:
                      '${DateFormat('hh:mm aa').format(booking.startTime)} to ${DateFormat('hh:mm aa').format(booking.endTime)}',
                ),
                const SizedBox(height: 16),
                DetailItem(
                  icon: Icons.attach_money,
                  title: "Price",
                  value: '\$${booking.price.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 16),
                DetailItem(
                  icon: Icons.info,
                  title: "Status",
                  value: booking.status,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button().borderedWhiteButton("Change Status", context, () {}),
            Button().smallBlueButton(
              "Call",
              context,
              () => Url.makePhoneCall(booking.userNumber),
            ),
          ],
        ),
      ),
    );
  }
}
