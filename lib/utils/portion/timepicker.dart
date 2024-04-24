import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../view_model/Getx/signup_controller/a02_signup_controller.dart';
import '../const/colors.dart';

class TimePicker extends StatefulWidget {
  final void Function(TimeOfDay?, TimeOfDay?) onTimeSelected;

  const TimePicker({super.key, required this.onTimeSelected});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  A02SignupController controller = Get.find();
  late TimeOfDay? openingTime;
  late TimeOfDay? closingTime;

  @override
  void initState() {
    super.initState();
    openingTime = controller.openingTimeFetch;
    closingTime = controller.closingTimeFetch;
  }

  Future<void> _selectTime(bool isOpening) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOpening
          ? openingTime ?? TimeOfDay.now()
          : closingTime ?? TimeOfDay.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isOpening) {
          openingTime = picked;
        } else {
          closingTime = picked;
        }
      });
      widget.onTimeSelected(openingTime, closingTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.045, vertical: height * 0.002),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: CustomColor.secondarybackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeSelector(
                title: 'Opening:',
                time: openingTime,
                onPressed: () => _selectTime(true),
              ),
              _buildTimeSelector(
                title: 'Closing:',
                time: closingTime,
                onPressed: () => _selectTime(false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector({
    required String title,
    required TimeOfDay? time,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 18,
                color: CustomColor.mainColor,
              ),
              const SizedBox(width: 4),
              Text(
                time != null
                    ? DateFormat.Hm()
                        .format(DateTime(2022, 1, 1, time.hour, time.minute))
                    : '00:00',
                style: TextStyle(
                  fontSize: 16,
                  color: time != null ? CustomColor.mainColor : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
