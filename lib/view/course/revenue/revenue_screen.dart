import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:owners_side_of_turf_booking/utils/portion/formater.dart';

import '../../../view_model/course/slot_request_controller.dart';

class Revenue extends StatelessWidget {
  const Revenue({super.key});

  @override
  Widget build(BuildContext context) {
    final SlotReservationController controller = Get.find();
    final bookings = controller.approvedBookings;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    // Group bookings by date
    Map<String, List<dynamic>> bookingsByDate = {};
    for (var booking in bookings) {
      String date = DateTime(booking.startTime.year, booking.startTime.month,
              booking.startTime.day)
          .toIso8601String();
      if (bookingsByDate[date] == null) {
        bookingsByDate[date] = [];
      }
      bookingsByDate[date]!.add(booking);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transactions",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.002),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Total Revenue:"),
                Text(
                  Formatter.formatCurrency(controller.totalTransaction),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: bookingsByDate.keys.length,
                itemBuilder: (BuildContext context, int index) {
                  String date = bookingsByDate.keys.elementAt(index);
                  List<dynamic> dailyBookings = bookingsByDate[date]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          DateFormat('dd-MM-yy').format(DateTime.parse(date)),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        children: dailyBookings.map((booking) {
                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Formatter.formatCurrency(booking.price),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        booking.username,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        Formatter.dateTimetoString(
                                            booking.startTime),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
