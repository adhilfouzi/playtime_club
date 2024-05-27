import 'package:flutter/material.dart';

import '../../../../utils/const/image_name.dart';

class HeaderWidget extends StatelessWidget {
  final double width;
  final double height;

  const HeaderWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: Colors.yellowAccent,
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
