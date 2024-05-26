import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as videoThumbnail;

import '../../../../config/routes/routes.dart';
import '../../../../domain/entities/entities.dart';

class PhotoCarouselProfile extends StatefulWidget {
  final List<MediaFile> images;
  final String basePhotoUrl;

  const PhotoCarouselProfile(
      {super.key, required this.images, required this.basePhotoUrl});

  @override
  _PhotoCarouselProfileState createState() => _PhotoCarouselProfileState();
}

class _PhotoCarouselProfileState extends State<PhotoCarouselProfile> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CarouselSlider.builder(
            clipBehavior: Clip.none,
            unlimitedMode: true,
            slideBuilder: (index) {
              _currentIndex = index;
              return _getUploadedImageView(widget.images[index]);
            },
            autoSliderDelay: const Duration(milliseconds: 3000),
            itemCount: widget.images.length,
            initialPage: _currentIndex,
            enableAutoSlider: false,
            onSlideChanged: (value) {
              setState(() {
                _currentIndex;
              });
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              PageViewIndicatorProfile(
                  currentPage: _currentIndex, pageCount: widget.images.length)
            ]),
          ),
        ],
      ),
    );
  }

  //Uploaded ImageView
  _getUploadedImageView(MediaFile data) => GestureDetector(
        onTap: () => _showMediaActionModal(data),
        child: data.mediaType == 'video'
            ? FutureBuilder<Uint8List?>(
                future: getVideoThumbnail(
                    '${widget.basePhotoUrl}/${data.mediaFilePath!}'),
                builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        height: 102,
                        width: 102,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.greyBg.withOpacity(0.1),
                        ),
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )));
                  }
                  if (snapshot.hasData) {
                    return getDecorationImage(
                        MemoryImage(snapshot.data!), true, data.mediaFilePath!);
                  }
                  return const Text("error");
                },
              )
            : getDecorationImage(
                CachedNetworkImageProvider(
                    '${widget.basePhotoUrl}/${data.mediaFilePath ?? ''}'),
                false,
                data.mediaFilePath!),
      );

  //Video Thumbnail
  Future<Uint8List?> getVideoThumbnail(String path) async {
    return await videoThumbnail.VideoThumbnail.thumbnailData(
      video: path, // video path
      imageFormat: videoThumbnail.ImageFormat.JPEG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
  }

  getDecorationImage(ImageProvider imageProvider, bool isVideo, String path) {
    return Container(
      key: ValueKey(path),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.greyBg.withOpacity(0.1),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: imageProvider,
          )),
      child: isVideo
          ? const Center(
              child: Icon(
                Iconsax.video5,
                size: 20,
                color: AppColors.primaryColor,
              ),
            )
          : Container(),
    );
  }

  //Action Modal
  _showMediaActionModal(MediaFile mediaFile) => showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
            title: Text('Choose Action',
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: Text(
                  'View ${mediaFile.mediaType == 'image' ? 'Image' : 'Video'}',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Get.toNamed(
                      mediaFile.mediaType == 'image'
                          ? imageViewPageRoute
                          : videoViewPageRoute,
                      parameters: {
                        'path':
                            '${widget.basePhotoUrl}/${mediaFile.mediaFilePath ?? ''}',
                        'preview': 'true',
                        'type': 'network'
                      });
                },
              ),
            ]),
      );
}

class PageViewIndicatorProfile extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const PageViewIndicatorProfile({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          pageCount,
          (index) {
            return currentPage == index
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: 16.0,
                    height: 3.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentPage == index
                          ? AppColors.primaryColor
                          : AppColors.white,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: 3.0,
                    height: 3.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == index ? null : AppColors.white,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
