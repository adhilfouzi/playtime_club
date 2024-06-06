import 'package:flutter/material.dart';

import '../../../../utils/const/colors.dart';
import '../../../../utils/const/image_name.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: CustomColor.slotavailable,
          width: width,
          height: height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset(
                  ImagePath.logo,
                  height: height * 0.15,
                  fit: BoxFit.contain,
                ),
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
      ),
    );
  }
}
