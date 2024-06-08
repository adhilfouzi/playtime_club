import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/const/image_name.dart';

class ProfileAvatar extends StatelessWidget {
  final String userPhotoUrl;

  const ProfileAvatar({super.key, required this.userPhotoUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: userPhotoUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: 64.0,
        backgroundColor: Colors.white,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const CircleAvatar(
          radius: 64.0,
          backgroundColor: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) => const CircleAvatar(
        radius: 64.0,
        backgroundImage: AssetImage(ImagePath.profile),
        backgroundColor: Colors.white,
      ),
    );
  }
}
