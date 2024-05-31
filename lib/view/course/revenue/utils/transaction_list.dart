import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utils/portion/formater.dart';

class TransactionList extends StatelessWidget {
  final Map<String, List<dynamic>> bookingsByDate;

  const TransactionList({
    super.key,
    required this.bookingsByDate,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: bookingsByDate.keys.length,
      itemBuilder: (BuildContext context, int index) {
        String date = bookingsByDate.keys.elementAt(index);
        List<dynamic> dailyBookings = bookingsByDate[date]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.005),
              child: Text(
                DateFormat('dd. MM.yy, EE')
                    .format(DateTime.parse(date)), // Format date correctly
                style: TextStyle(
                  fontSize: width * 0.05, // Adjust font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: dailyBookings.map((booking) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Formatter.formatCurrency(booking.amount),
                              style: TextStyle(
                                fontSize: width * 0.045, // Adjust font size
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              booking.username,
                              style: TextStyle(
                                fontSize: width * 0.04, // Adjust font size
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
                                  booking.transactionDate),
                              style: TextStyle(
                                fontSize: width * 0.04, // Adjust font size
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
    );
  }
}
