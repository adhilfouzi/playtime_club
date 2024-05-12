import 'package:flutter/material.dart';

import '../../../../../../model/controller/validator.dart';
import '../../../../../../utils/const/colors.dart';
import '../../../../../../utils/portion/textfield.dart';
import '../../../../../../view_model/onboarding/signup_controller/a02_signup_controller.dart';

class DescriptionTextField extends StatelessWidget {
  final A02SignupController controller;

  const DescriptionTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      validator: (value) => InputValidators.validateEmpty("Description", value),
      maxLines: 4,
      minLines: 4,
      maxLength: 450,
      buildCounter: (BuildContext context,
          {int? currentLength, int? maxLength, bool? isFocused}) {
        bool isMaxLengthReached = currentLength! >= (maxLength ?? 450);
        return Text(
          isMaxLengthReached ? 'Max length reached' : '$currentLength / ${450}',
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
      controller: controller.descriptionController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
    );
  }
}
