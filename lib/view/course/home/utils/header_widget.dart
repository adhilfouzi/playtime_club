import 'package:flutter/material.dart';
import 'package:owners_side_of_turf_booking/utils/const/colors.dart';

import '../../../../utils/const/image_name.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: CustomColor.slotavailable,
        width: width,
        height: height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.06,
              width: width,
              child: Image.asset(logo),
            ),
            const Text(
              "Unleash Your Game, Secure Slot Reservation",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text(
              "Your Premier Hub for Effortless Sports Reservations",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
      ),
    );
  }
}
