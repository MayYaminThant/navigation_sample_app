part of 'widgets.dart';

class CustomImageView extends StatefulWidget {
  ///[url] is required parameter for fetching network image
  final String? url;

  ///[imagePath] is required parameter for showing png,jpg,etc image
  final String? imagePath;

  ///[svgPath] is required parameter for showing svg image
  final String? svgPath;

  ///[file] is required parameter for fetching image file
  final File? file;

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

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  const CustomImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
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
  String basePhotoUrl = '';
  @override
  void initState() {
    _getPhotoUrl();
    super.initState();
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: widget.onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (widget.radius != null) {
      return ClipRRect(
        borderRadius: widget.radius,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (widget.border != null) {
      return Container(
        decoration: BoxDecoration(
          border: widget.border,
          borderRadius: widget.radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (widget.file != null && widget.file!.path.isNotEmpty) {
      return Image.file(
        widget.file!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.cover,
        color: widget.color,
      );
    } else if (widget.url != null && widget.url!.isNotEmpty) {
      return CachedNetworkImage(
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.cover,
        imageUrl: '$basePhotoUrl/${widget.url!}',
        color: widget.color,
        placeholder: (context, url) => SizedBox(
          height: 30,
          width: 30,
          child: LinearProgressIndicator(
            color: Colors.grey.shade200,
            backgroundColor: Colors.grey.shade100,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          widget.placeHolder,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
        ),
      );
    } else if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      return Image.asset(
        widget.imagePath!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.cover,
        color: widget.color,
      );
    }
    return const SizedBox();
  }
}
