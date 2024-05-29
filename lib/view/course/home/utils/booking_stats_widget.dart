import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../utils/const/colors.dart';
import '../../../../utils/const/icons_image.dart';
import '../../../../utils/portion/formater.dart';
import '../../../../view_model/course/transaction_controller.dart';

class BookingStatsWidget extends StatelessWidget {
  const BookingStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TransactionController booking = Get.put(TransactionController());
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: CustomColor.mainColor,
        width: width,
        height: height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: width * 0.02),
                    SvgPicture.asset(
                      AppIcons.revenue,
                      width: 24,
                      height: 24,
                      color: Colors.black,
                    ),
                    SizedBox(width: width * 0.05),
                    const Text(
                      "Total Booking",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      booking.transaction.length.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                  ],
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: width * 0.02),
                    SvgPicture.asset(
                      AppIcons.shoppingBag,
                      width: 24,
                      height: 24,
                      color: Colors.black,
                    ),
                    SizedBox(width: width * 0.05),
                    const Text(
                      "Total Transaction",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      Formatter.formatCurrency(booking.totalAmount),
                      style: const TextStyle(
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
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
