import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:dh_mobile/src/core/utils/snackbar_utils.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/background_scaffold.dart';
import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
import 'package:dh_mobile/src/presentations/widgets/upload_preview.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UploadMediaCamera extends StatefulWidget {
  final bool isOnlyPhoto;
  final bool isContactUs;

  const UploadMediaCamera(
      {super.key, required this.isOnlyPhoto, required this.isContactUs});

  @override
  State<UploadMediaCamera> createState() => _UploadMediaCameraState();
}

class _UploadMediaCameraState extends State<UploadMediaCamera> {
  List<CameraDescription> cameras = <CameraDescription>[];
  CameraController? _cameraController;
  bool flash = false;
  double transform = 0;
  Timer _timer = Timer(Duration.zero, () {});
  int _start = 10;
  Future<void>? initializeControllerFuture;
  bool isPhotoOnly = false;

  @override
  void initState() {
    _initializeController();
    super.initState();
  }

  Future<void> _initializeController() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    initializeControllerFuture = _cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) async {
      superPrint(e);
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        Navigator.of(context).pop();
        showErrorSnackBar(
            "Phluid does not has permission to access your camera. Please go to setting and enable permission for camera access to Phluid app, try again.");
      });
    });
    _cameraController?.setFlashMode(FlashMode.off);
    if (!mounted) {
      return;
    }
    setState(() {
      isPhotoOnly = widget.isOnlyPhoto;
    });
  }

  Future<void> _toggleCamera() async {
    cameras = await availableCameras();
    final CameraDescription newCameraDescription =
        (_cameraController?.description == cameras[0])
            ? cameras[1]
            : cameras[0];

    await _cameraController?.dispose();
    _cameraController =
        CameraController(newCameraDescription, ResolutionPreset.max);
    initializeControllerFuture = _cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) async {
      superPrint(e);
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        Navigator.of(context).pop();
        showErrorSnackBar(
            "Phluid does not has permission to access your camera. Please go to setting and enable permission for camera access to Phluid app, try again.");
      });
    });
    _cameraController?.setFlashMode(FlashMode.off);
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _timer.cancel();
    _start = 10;
    super.dispose();
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.black,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      leadingWidth: 52,
      title: Text(
        isPhotoOnly
            ? StringConst.cameraText
            : "${StringConst.cameraText} ${_start != 0 ? '($_start sec)' : ''}",
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w100),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      actions: const [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      availableBack: true,
      scaffold: Scaffold(
          backgroundColor: Colors.black,
          appBar: _getAppBar,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                if (_cameraController != null)
                  !_cameraController!.value.isInitialized
                      ? const Center(child: CircularProgressIndicator())
                      : _cameraController!.description.lensDirection ==
                              CameraLensDirection.front
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: CameraPreview(_cameraController!))
                          : CameraPreview(_cameraController!),
                if (_cameraController != null)
                  if (_cameraController!.value.isInitialized)
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      flash ? Icons.flash_on : Icons.flash_off,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        flash = !flash;
                                      });
                                      flash
                                          ? _cameraController!
                                              .setFlashMode(FlashMode.torch)
                                          : _cameraController!
                                              .setFlashMode(FlashMode.off);
                                    }),
                                GestureDetector(
                                  onLongPress: () async {
                                    if (!isPhotoOnly) {
                                      await _cameraController!
                                          .startVideoRecording();
                                      startTimer();
                                    }
                                  },
                                  onLongPressUp: () async {
                                    if (!isPhotoOnly) {
                                      _longPressUp();
                                    }
                                  },
                                  onTap: () async {
                                    if (!_timer.isActive) {
                                      final XFile? data = await takePhoto();
                                      if (context.mounted) {
                                        if (data != null) {
                                          final File fileData = File(data.path);
                                          final File? fileUpload =
                                              await openUploadPreview(
                                                  context: context,
                                                  file: fileData,
                                                  isPreview: false,
                                                  isVideo: false);
                                          if (fileUpload != null) {
                                            if (context.mounted) {
                                              Navigator.of(context)
                                                  .pop(fileUpload);
                                            }
                                          }
                                        }
                                      }
                                    }
                                  },
                                  child: _timer.isActive
                                      ? const Icon(
                                          Icons.radio_button_on,
                                          color: Colors.red,
                                          size: 80,
                                        )
                                      : const Icon(
                                          Icons.panorama_fish_eye,
                                          color: Colors.white,
                                          size: 70,
                                        ),
                                ),
                                IconButton(
                                    icon: Transform.rotate(
                                      angle: transform,
                                      child: const Icon(
                                        Icons.flip_camera_ios,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _toggleCamera();
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          )),
    );
  }

  Future<XFile?> takePhoto() async {
    superPrint(isPhotoOnly);
    XFile? file = await _cameraController?.takePicture();
    return file;
  }

  void _longPressUp() async {
    final XFile? data = await _retrieveVideo();
    if (context.mounted) {
      if (data != null) {
        final File fileData = File(data.path);
        _cameraController?.setFlashMode(FlashMode.off);
        final File? fileUpload = await openUploadPreview(
            context: context, file: fileData, isPreview: false, isVideo: true);
        if (fileUpload != null) {
          superPrint(data.path);
          if (context.mounted) {
            Navigator.of(context).pop(fileUpload);
          }
        }
      }
    }
  }

  Future<XFile?> _retrieveVideo() async {
    try {
      final XFile file = await _cameraController!.stopVideoRecording();
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<File?> openUploadPreview(
      {required BuildContext context,
      required File file,
      required bool isPreview,
      required bool isVideo}) async {
    try {
      _timer.cancel();
    } catch (e) {
      // ignore if timer is already stopped
    }
    setState(() {
      _start = 10;
    });
    return showDialog<File?>(
      context: context,
      builder: (BuildContext context) {
        return UploadPreview(
          originalFile: file,
          preview: isPreview,
          isVideo: isVideo,
          isContactUs: widget.isContactUs,
        );
      },
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
          _longPressUp();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
