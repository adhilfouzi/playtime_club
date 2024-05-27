import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view_model/course/slot_request_controller.dart';
import '../../../../utils/const/colors.dart';
import '../../../../utils/const/icons_image.dart';
import '../../../../utils/portion/formater.dart';

class BookingStatsWidget extends StatelessWidget {
  final double width;
  final double height;

  const BookingStatsWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final SlotRequestController booking = Get.find();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: CustomColor.mainColor,
        width: width,
        height: height * 0.1,
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                SizedBox(width: width * 0.28),
                Text(
                  booking.totalBooking.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: width * 0.02),
              ],
            ),
            SizedBox(height: height * 0.01),
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
                SizedBox(width: width * 0.21),
                Text(
                  Formatter.formatCurrency(booking.totalTransaction),
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
      ),
    );
  }
}
