import 'package:flutter/material.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/const/image_name.dart';

class SubmissionSuccessful extends StatelessWidget {
  const SubmissionSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * 0.25,
                width: width,
                child: Image.asset(logo),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'BUSINESS ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: CustomColor.mainColor,
                    ),
                  ),
                  Text(
                    'Registration',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.mainColor,
                    ),
                  ),
                ],
              ),
              const Text(
                'Submission Successful',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const Text(
                'Request ID : SM184006022024',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              SizedBox(height: height * 0.05),
              SizedBox(
                width: width * 0.8,
                child: const Text(
                  '''All of the details you have submitted have been received by us. We will check and update you once we have reviewed your profile. This process may take around 3 to 4 business days.
              
              Please feel free to contact us using the details below if you have any questions or queries.''',
                  style: TextStyle(),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: height * 0.05),
              const Text(
                'info@spotme.in',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
