import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dh_mobile/src/core/utils/image_utils.dart';
import 'package:dh_mobile/src/core/utils/snackbar_utils.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/background_scaffold.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:video_player/video_player.dart';

class UploadPreview extends StatefulWidget {
  final File originalFile;
  final bool preview;
  final bool isVideo;
  final bool isContactUs;

  const UploadPreview(
      {super.key,
      required this.originalFile,
      required this.preview,
      required this.isVideo,
      this.isContactUs = false});

  @override
  State<UploadPreview> createState() => _UploadPreviewState();
}

class _UploadPreviewState extends State<UploadPreview> {
  final TransformationController _transformationController =
      TransformationController();
  double _scale = 1.0;
  double _previousScale = 1.0;
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  File? croppedFile;
  bool submitLoading = false;

  @override
  void initState() {
    setState(() {
      croppedFile = widget.originalFile;
    });
    videoInitialize();
    super.initState();
  }

  void videoInitialize() {
    if (widget.isVideo) {
      if (widget.preview) {
        setState(() {
          _controller = VideoPlayerController.network(widget.originalFile.path)
            ..initialize().then((_) {
              _chewieController = ChewieController(
                videoPlayerController: _controller!,
                autoPlay: true,
                allowFullScreen: false,
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
        });
      } else {
        setState(() {
          _controller =
              VideoPlayerController.file(File(widget.originalFile.path))
                ..initialize().then((_) {
                  _chewieController = ChewieController(
                    videoPlayerController: _controller!,
                    autoPlay: true,
                    allowFullScreen: false,
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
        });
      }
      _controller!.addListener(() {
        setState(() {});
      });
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController?.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    return BackgroundScaffold(
      availableBack: true,
      scaffold: Scaffold(
          backgroundColor: AppColors.black,
          body: Stack(
            children: [
              SizedBox(
                height: widget.preview ? appBarHeight : appBarHeight * 2,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Iconsax.arrow_left,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      widget.preview
                          ? widget.isVideo
                              ? StringConst.videoText
                              : StringConst.imageText
                          : widget.isVideo
                              ? StringConst.videoPreviewText
                              : StringConst.imagePreviewText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w100),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.isVideo
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: _controller!.value.isInitialized &&
                                  _chewieController != null
                              ? AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: Chewie(controller: _chewieController!),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )),
                        )
                      : Stack(children: [
                          GestureDetector(
                            onScaleStart: (ScaleStartDetails details) {
                              setState(() {
                                _previousScale = _scale;
                              });
                            },
                            onScaleUpdate: (ScaleUpdateDetails details) {
                              setState(() {
                                _scale = (_previousScale * details.scale)
                                    .clamp(1.0, 4.0);
                                _transformationController.value =
                                    Matrix4.identity()..scale(_scale);
                              });
                            },
                            child: InteractiveViewer(
                              transformationController:
                                  _transformationController,
                              maxScale: 4.0,
                              child: Center(
                                child: croppedFile == null
                                    ? const CircularProgressIndicator()
                                    : CustomImageView(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.75,
                                        image: croppedFile!.path,
                                        fit: BoxFit.contain,
                                        fileImage: croppedFile,
                                      ),
                              ),
                            ),
                          ),
                        ]),
                ],
              ),
              Positioned(
                bottom: 20.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.isVideo) const SizedBox(),
                        if (!widget.isVideo)
                          if (!widget.preview)
                            CustomOutlineButton(
                              widthButton: 130.0,
                              icon:
                                  const Icon(Iconsax.crop, color: Colors.black),
                              customColor: Colors.white,
                              textColor: Colors.black,
                              text: 'Crop'.tr,
                              onPressed: _cropImage,
                            ),
                        !widget.preview
                            ? GestureDetector(
                                onTap: () async => await _submit(),
                                child: CircleAvatar(
                                  radius: 27,
                                  backgroundColor: AppColors.primaryColor,
                                  child: submitLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                      : const Icon(
                                          Iconsax.direct_right,
                                          color: Colors.white,
                                          size: 27,
                                        ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  void _cropImage() async {
    CroppedFile? newFile = await ImageCropper().cropImage(
      sourcePath: widget.originalFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Photo'.tr,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Photo'.tr,
        ),
      ],
    );
    if (newFile == null) return;

    setState(() {
      croppedFile = File(newFile.path);
    });
  }

  Future<void> _submit() async {
    if (submitLoading) return;
    setState(() {
      submitLoading = true;
    });
    final CompressReturn compressReturn = await ImageUtils.compressMediaFile(
        croppedFile,
        contactUsSize: widget.isContactUs ? 7000000 : 0);
    if (!mounted) return;
    setState(() {
      submitLoading = false;
    });
    if (compressReturn.file == null) {
      Navigator.of(context).pop();
      showErrorSnackBar("${compressReturn.message}", duration: 5);
      return;
    }
    Navigator.of(context).pop(compressReturn.file);
  }
}
