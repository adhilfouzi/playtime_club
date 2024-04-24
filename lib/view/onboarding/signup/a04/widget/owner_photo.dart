import 'package:flutter/material.dart';

import '../../../../../utils/const/image_name.dart';

class OwnerPhoto extends StatelessWidget {
  const OwnerPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.32,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(profile),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Owner photo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: width * 0.545,
                  child: const Text(
                    "Your Face should be visible completely. Image with Space & headphone will not be approved",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
