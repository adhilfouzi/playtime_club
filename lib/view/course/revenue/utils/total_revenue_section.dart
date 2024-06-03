import 'package:flutter/material.dart';
import '../../../../utils/portion/formater.dart';

class TotalRevenueSection extends StatelessWidget {
  final double revenueAsPerDay;
  final double totalAmount;

  const TotalRevenueSection({
    super.key,
    required this.revenueAsPerDay,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Revenue on Filter",
                      style: TextStyle(
                        fontSize: width * 0.038,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      Formatter.formatCurrency(revenueAsPerDay),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.06,
                      ),
                    ),
                  ],
                ),
                VerticalDivider(
                  width: width * 0.02,
                  thickness: 2,
                  color: Colors.yellow,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total Revenue",
                      style: TextStyle(
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      Formatter.formatCurrencyK(totalAmount),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.06,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
