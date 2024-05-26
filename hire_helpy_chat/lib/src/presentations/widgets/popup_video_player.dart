import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../values/values.dart';

class PopupVideoPlayer extends StatefulWidget {
  final String videoPath;

  const PopupVideoPlayer({super.key, required this.videoPath});

  @override
  State<PopupVideoPlayer> createState() => _PopupVideoPlayerState();
}

class _PopupVideoPlayerState extends State<PopupVideoPlayer> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoPath)
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
      });
    _controller.addListener(() {
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: _controller.value.isInitialized && _chewieController != null
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(children: [
                      AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: Chewie(controller: _chewieController!))
                    ]),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ))));
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController?.dispose();
    _controller.dispose();
  }
}
