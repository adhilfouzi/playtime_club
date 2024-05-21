import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../view_model/course/usermodel_controller.dart';
import '../../../../../../view_model/onboarding/signup/image_controller.dart';

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
                      imageController.deleteTurfImage(index);
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
