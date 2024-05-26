import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_employer/src/presentations/widgets/popup_video_player.dart';
import 'package:flutter/material.dart';

import '../values/values.dart';

class VideoWidget extends StatelessWidget {
  final String path;
  final String? thumbnailPath;
  final double? width;
  final double? height;

  const VideoWidget(
      {required this.path,
      this.thumbnailPath,
      this.width,
      this.height,
      required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => PopupVideoPlayer(
                    videoPath: path,
                  ));
        },
        child: Stack(children: [
          CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: thumbnailPath ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            )),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/logo.png'),
          ),
          const Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  )))
        ]));
  }
}
