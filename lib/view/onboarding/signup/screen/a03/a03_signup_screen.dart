import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:owners_side_of_turf_booking/view_model/onboarding/signup_controller/image_controller.dart';

import '../../../../../view_model/course/usermodel_controller.dart';
import '../../../../../view_model/onboarding/signup_controller/a03_signup_controller.dart';
import '../../utils/appbar.dart';
import '../../../../../utils/portion/button.dart';

class A03SignupScreen extends StatelessWidget {
  A03SignupScreen({super.key});

  final controller = Get.put(A03SignupController());
  final UserController userController = Get.find();
  final ImageController imageController = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: const SignupAppBar(
          noLeading: false,
        ),
        body: Column(
          children: [
            const Text('Upload minimum 3 images of your Business'),
            SizedBox(
              height: height * 0.02,
            ),
            const ImagesGrid(),
            SizedBox(height: height * 0.04),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Button().withAdd('Next', context, () {
            controller.submit();
          }, () {
            imageController.openDialog(false);
          }),
        ),
      ),
    );
  }
}

class ImagesGrid extends StatelessWidget {
  const ImagesGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    final ImageController imageController = Get.find();
    return Expanded(
      child: Obx(() {
        var images = userController.user.value.images;
        return images.isEmpty
            ? const Center(
                child: Text(
                  "Add at least 3 images of your Business",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  var image = images[index];
                  return InkWell(
                    onTap: () {
                      imageController.aDialogforDelete(index);
                    },
                    child: Card(
                      elevation: 5,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }
}
