import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:owners_side_of_turf_booking/utils/const/colors.dart';
import '../../../utils/const/icons_image.dart';
import '../../../utils/const/image_name.dart';
import '../portion/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const HomeScreenAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: Colors.yellowAccent,
                width: width * 1,
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
            ),
            SizedBox(height: height * 0.02),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: CustomColor.mainColor,
                width: width * 1,
                height: height * 0.1,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        const Text(
                          "2.85K",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.,
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
                          "Total Booking",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: width * 0.28),
                        const Text(
                          "2.85K",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: CustomColor.mainColor,
                width: width * 1,
                height: height * 0.05,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Slot Allotting"),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                      // SizedBox(width: width * 0.002),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
