import 'package:flutter/material.dart';
import 'package:owners_side_of_turf_booking/model/controller/validator.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/portion/snackbar.dart';
import 'utils/appbar.dart';
import '../../../utils/portion/button.dart';
import 'utils/fetch_location.dart';
import '../../../utils/portion/textfield.dart';
import '../../../utils/portion/timepicker.dart';
import 'a03_signup_screen.dart';

class A02SignupScreen extends StatelessWidget {
  final String courtName;
  final String courtPhoneNumber;
  final String courtEmailAddress;

  A02SignupScreen({
    super.key,
    required this.courtName,
    required this.courtPhoneNumber,
    required this.courtEmailAddress,
  });

  final TextEditingController descriptionAboutTurfTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    TimeOfDay? openingTimeFetch;
    TimeOfDay? closingTimeFetch;
    String? courtLocation = '';

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomBottomAppBar(),
        body: SingleChildScrollView(
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
                controller: descriptionAboutTurfTextEditingController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              TimePicker(
                onTimeSelected: (openingTime, closingTime) {
                  openingTimeFetch = openingTime;
                  closingTimeFetch = closingTime;
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
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.025),
          child: Button().mainButton('Next', context, () {
            if (openingTimeFetch != null && closingTimeFetch != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => A03SignupScreen(
                    courtName: courtName,
                    courtPhoneNumber: courtPhoneNumber,
                    courtEmailAddress: courtEmailAddress,
                    openingTime: openingTimeFetch!,
                    closingTime: closingTimeFetch!,
                    courtLocation: courtLocation,
                    courtDescription:
                        descriptionAboutTurfTextEditingController.text,
                  ),
                ),
              );
            } else {
              CustomSnackbar.showError('Please fill in all required fields.');
            }
          }),
        ),
      ),
    );
  }
}
