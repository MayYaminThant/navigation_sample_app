part of 'widgets.dart';

class CustomVideoView extends StatefulWidget {
  final String videoUrl;
  final String thumbnail;

  const CustomVideoView(
      {super.key, required this.videoUrl, required this.thumbnail});

  @override
  CustomVideoViewState createState() => CustomVideoViewState();
}

class CustomVideoViewState extends State<CustomVideoView> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  k_connection_state.ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          if (!_isPlaying)
            const Positioned(
              top: 80,
              left: 150,
              child: Icon(
                Icons.play_arrow,
                size: 60,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
