import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFilter extends StatelessWidget {
  final bool isRevenue;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTimeRange?) onDateRangeSelected;

  const DateFilter({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onDateRangeSelected,
    required this.isRevenue,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () async {
            final DateTimeRange? picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: isRevenue ? DateTime.now() : DateTime(2101),
              initialDateRange: isRevenue
                  ? null
                  : DateTimeRange(start: startDate!, end: endDate!),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Colors.white,
                      surface: Theme.of(context).primaryColor,
                      onSurface: Colors.black,
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                  child: child!,
                );
              },
            );
            onDateRangeSelected(picked);
          },
          child: Text(
            "Filter",
            style: TextStyle(
              fontSize: width * 0.04,
            ),
          ),
        ),
        if (startDate != null && endDate != null)
          Text(
            "${DateFormat('dd.MM.yy').format(startDate!)} to ${DateFormat('dd.MM.yy').format(endDate!)}",
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          )
        else
          Text(
            'All Days',
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
