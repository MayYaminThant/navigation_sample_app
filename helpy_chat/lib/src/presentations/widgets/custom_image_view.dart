part of 'widgets.dart';

enum ImageType { network, file, asset, server, unknown }

class CustomImageView extends StatefulWidget {
  final String image;
  final File? fileImage;
  final bool isVideo;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final String placeHolder;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;

  const CustomImageView({
    super.key,
    this.image = 'assets/images/logo.png',
    this.fileImage,
    this.isVideo = false,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/logo.png',
  });

  @override
  State<CustomImageView> createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  String candidateConfig = "";

  @override
  void initState() {
    getConfig();
    super.initState();
  }

  static ImageType _getImageType(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return ImageType.network;
    } else if (path.startsWith('/data/') || File(path).existsSync()) {
      return ImageType.file;
    } else if (path.startsWith('assets/')) {
      return ImageType.asset;
    } else if (path.startsWith('dh/')) {
      return ImageType.server;
    } else {
      return ImageType.unknown;
    }
  }

  Future<void> getConfig() async {
    final String? data =
        await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    if (data != null) {
      setState(() {
        candidateConfig = data;
      });
    }
  }

  //Video Thumbnail
  Future<Uint8List?> _getVideoThumbnail(String path) async {
    return await video_thumbnail.VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: video_thumbnail.ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment!,
            child: _buildWidget,
          )
        : _buildWidget;
  }

  Widget get _getVideoImage => FutureBuilder<Uint8List?>(
        future: _getVideoThumbnail(widget.fileImage!.path),
        builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
          return snapshot.data == null
              ? const SizedBox(
                  height: 102,
                  width: 102,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  height: 102,
                  width: 102,
                  margin: const EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.greyBg.withOpacity(0.1),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(snapshot.data!),
                      )));
        },
      );

  Widget get _buildWidget => Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: InkWell(
          onTap: widget.onTap,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.passthrough,
            children: [
              widget.isVideo && !widget.fileImage!.path.startsWith("dh/")
                  ? _getVideoImage
                  : _buildCircleImage,
              if (widget.isVideo)
                const Positioned(
                    right: 20,
                    left: 20,
                    top: 20,
                    bottom: 20,
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black38,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        )))
            ],
          ),
        ),
      );

  ///build the image with border radius
  Widget get _buildCircleImage => widget.radius != null
      ? ClipRRect(
          borderRadius: widget.radius ?? BorderRadius.circular(999),
          child: _buildImageWithBorder,
        )
      : _buildImageWithBorder;

  ///build the image with border and border radius style
  Widget get _buildImageWithBorder => widget.border != null
      ? Container(
          decoration: BoxDecoration(
            border: widget.border,
            borderRadius: widget.radius,
          ),
          child: _buildImageView,
        )
      : _buildImageView;

  Widget get _buildImageView {
    String photoUrl = widget.image;
    final ImageType imageType = _getImageType(photoUrl);
    if (photoUrl.isNotEmpty) {
      switch (imageType) {
        case ImageType.server:
          if (photoUrl.endsWith('.svg')) {
            return SvgPicture.asset(
              "$candidateConfig/$photoUrl",
              height: widget.height,
              width: widget.width,
              fit: widget.fit ?? BoxFit.contain,
              alignment: widget.alignment ?? Alignment.center,
              placeholderBuilder: (context) => _buildPlaceholder,
            );
          }
          return CachedNetworkImage(
            imageUrl: "$candidateConfig/$photoUrl",
            height: widget.height,
            width: widget.width,
            fit: widget.fit,
            placeholder: (context, url) => _buildLoading,
            errorWidget: (context, url, error) => _buildPlaceholder,
          );
        case ImageType.network:
          if (photoUrl.endsWith('.svg')) {
            return SvgPicture.asset(
              photoUrl,
              height: widget.height,
              width: widget.width,
              fit: widget.fit ?? BoxFit.contain,
              alignment: widget.alignment ?? Alignment.center,
              placeholderBuilder: (context) => _buildPlaceholder,
            );
          }
          return CachedNetworkImage(
            imageUrl: photoUrl,
            height: widget.height,
            width: widget.width,
            fit: widget.fit,
            placeholder: (context, url) => _buildLoading,
            errorWidget: (context, url, error) => _buildPlaceholder,
          );
        case ImageType.file:
          return widget.fileImage == null
              ? _buildPlaceholder
              : Image.file(
                  widget.fileImage!,
                  height: widget.height,
                  width: widget.width,
                  fit: widget.fit ?? BoxFit.contain,
                  color: widget.color,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey,
                    width: 100,
                    height: 100,
                    child: const Center(
                      child:
                          Text('Error load image', textAlign: TextAlign.center),
                    ),
                  ),
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) =>
                          Container(
                    child: child,
                  ),
                );
        case ImageType.asset:
          return Image.asset(
              photoUrl.isEmpty ? 'assets/images/logo.png' : photoUrl,
              height: widget.height,
              width: widget.width,
              fit: widget.fit ?? BoxFit.contain,
              color: widget.color);
        default:
          return _buildPlaceholder;
      }
    } else {
      return _buildPlaceholder;
    }
  }

  Widget get _buildPlaceholder => Image.asset(
        widget.placeHolder,
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.contain,
        color: widget.color,
        alignment: widget.alignment ?? Alignment.center,
      );

  Widget get _buildLoading => const Center(
          child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ));
}
