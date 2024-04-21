import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/model/controller/validator.dart';
import '../../../utils/const/colors.dart';
import '../../../view_model/Getx/business_registration_controller.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import 'utils/fetch_location.dart';
import '../../../utils/portion/textfield.dart';
import '../../../utils/portion/timepicker.dart';

class A02SignupScreen extends StatelessWidget {
  A02SignupScreen({
    super.key,
  });
  final controller = Get.put(BusinessRegistration());
  final GlobalKey<FormState> a20FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomBottomAppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: a20FormKey,
            child: Column(
              children: [
                SizedBox(height: height * 0.2),
                MyTextField(
                  validator: (value) =>
                      InputValidators.validateEmpty("Description", value),
                  maxLines: 4,
                  minLines: 4,
                  maxLength: 450,
                  buildCounter: (BuildContext context,
                      {int? currentLength, int? maxLength, bool? isFocused}) {
                    bool isMaxLengthReached =
                        currentLength! >= (maxLength ?? 450);
                    return Text(
                      isMaxLengthReached
                          ? 'Max length reached'
                          : '$currentLength / ${450}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isFocused != null && isFocused
                            ? isMaxLengthReached
                                ? Colors.red
                                : CustomColor.mainColor
                            : Colors.grey,
                      ),
                    );
                  },
                  hintText: "Description about turf",
                  labelText: 'About Court',
                  controller:
                      controller.descriptionAboutTurfTextEditingController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                TimePicker(
                  onTimeSelected: (openingTime, closingTime) {
                    controller.openingTimeFetch = openingTime;
                    controller.closingTimeFetch = closingTime;
                  },
                ),
                const LocationCaller(
                    // onLocationSelected: (location) {
                    //   courtLocation = location;
                    // },
                    ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.025),
          child: Button().mainButton('Next', context, () {
            if (!a20FormKey.currentState!.validate()) return;
            controller.a02Submit();
          }),
        ),
      ),
    );
  }
}
