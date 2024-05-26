import 'package:dh_mobile/src/presentations/widgets/popup_video_player.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
          CustomImageView(
            image: "$thumbnailPath",
            width: width,
            height: height,
            fit: BoxFit.cover,
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
