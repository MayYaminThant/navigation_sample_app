part of 'widgets.dart';

class ZoomableImage extends StatefulWidget {
  final ImageProvider image;
  final double maxScale;
  final String tag;

  const ZoomableImage(
      {super.key, required this.image, this.maxScale = 4.0, required this.tag});

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  final TransformationController _transformationController =
      TransformationController();

  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      backgroundColor: Colors.transparent,
      child: Hero(
        tag: widget.tag,
        child: GestureDetector(
          onScaleStart: (ScaleStartDetails details) {
            _previousScale = _scale;
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              _scale =
                  (_previousScale * details.scale).clamp(1.0, widget.maxScale);
              _transformationController.value = Matrix4.identity()
                ..scale(_scale);
            });
          },
          child: InteractiveViewer(
            transformationController: _transformationController,
            maxScale: widget.maxScale,
            child: Image(
              image: widget.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}