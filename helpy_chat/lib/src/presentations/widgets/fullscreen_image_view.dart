import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:io';

import '../values/values.dart';

class FullscreenImageView extends StatelessWidget {
  const FullscreenImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      backgroundColor: Colors.black,
      body: _zoomableImage,
    );
  }

  Widget get _zoomableImage {
    String? imagePath = Get.parameters["path"];
    String imageType = Get.parameters["type"] ?? 'network';
    if (imagePath == null) return Container();

    Widget image = imageType == 'network'
        ? CachedNetworkImage(
            imageUrl: imagePath,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
          )
        : Image.file(File(imagePath));

    return Center(
        child: InteractiveViewer(maxScale: 5, clipBehavior: Clip.none, child: image));
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      backgroundColor: Colors.black,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      title: const Text(
        StringConst.imagePreviewText,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w100),
      ),
    );
  }
}
