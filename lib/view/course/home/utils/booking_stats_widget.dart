import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final TransactionController booking = Get.find();

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: CustomColor.mainColor,
        width: width,
        height: height * 0.13,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.02, horizontal: width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.revenue,
                        width: 24,
                        height: 24,
                        color: Colors.black,
                      ),
                      SizedBox(width: width * 0.02),
                      const Text(
                        "Total Booking",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Obx(() => Text(
                        booking.transaction.length.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )),
                ],
              ),
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.shoppingBag,
                        width: 24,
                        height: 24,
                        color: Colors.black,
                      ),
                      SizedBox(width: width * 0.02),
                      const Text(
                        "Total Transaction",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Obx(() => Text(
                        Formatter.formatCurrencyK(booking.totalAmount),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
