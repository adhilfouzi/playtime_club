import 'package:flutter/material.dart';

import '../../../../utils/appbar/titleonly_appbar.dart';
import '../../../../utils/portion/timepicker.dart';
import '../../../../view_model/onboarding/signup/signup_controller.dart';
import '../../../onboarding/signup/screen/signup_timing_price/widget/signup_bottom_navigation_bar.dart';

class ChooseTurfTime extends StatelessWidget {
  final SignupController controller;
  const ChooseTurfTime({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TitleOnlyAppBar(title: "Turf Time"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimePicker(
              onTimeSelected: (openingTime, closingTime, isOpen24Hours) {
                controller.openingTimeFetch = openingTime;
                controller.closingTimeFetch = closingTime;
                controller.isOpen24Hours.value = isOpen24Hours;
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          buttonText: 'Save',
          onSubmit: controller.submitTime,
        ));
  }
}
