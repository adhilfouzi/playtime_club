import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../view_model/course/usermodel_controller.dart';
import '../../../../../../view_model/onboarding/signup/image_controller.dart';

class ImagesGrid extends StatelessWidget {
  const ImagesGrid({super.key});

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
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  var image = images[index];
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.grey[300],
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            imageController.deleteTurfImage(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 255, 0, 0),
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
      }),
    );
  }
}
