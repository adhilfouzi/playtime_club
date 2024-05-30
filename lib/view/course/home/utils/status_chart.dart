import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/utils/portion/formater.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../view_model/course/transaction_controller.dart';

class StatusChart extends StatefulWidget {
  const StatusChart({super.key});
  @override
  State<StatusChart> createState() => _StatusChartState();
}

class _StatusChartState extends State<StatusChart> {
  final TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Obx(() {
          if (transactionController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (transactionController.errorMessage.isNotEmpty) {
            return Center(child: Text(transactionController.errorMessage));
          } else {
            List<_SalesData> data = transactionController.transaction
                .map((transaction) => _SalesData(
                      Formatter.dateTimetoString(transaction.transactionDate),
                      transaction.amount,
                    ))
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transaction Amount Over Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: SfCartesianChart(
                    primaryXAxis: const CategoryAxis(),
                    // Enable legend
                    legend: const Legend(isVisible: true),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<dynamic, String>>[
                      // Change the type here
                      LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Amount',
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
