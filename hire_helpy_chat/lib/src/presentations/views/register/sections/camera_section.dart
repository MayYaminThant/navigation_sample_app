part of '../../views.dart';

class CameraSection extends StatefulWidget {
  const CameraSection({Key? key}) : super(key: key);

  @override
  State<CameraSection> createState() => _CameraSectionState();
}

class _CameraSectionState extends State<CameraSection> {
  List<CameraDescription> cameras = [];
  CameraController? _cameraController;
  bool isRecoring = false;
  bool flash = false;
  double transform = 0;
  String route = '';
  Timer? _timer;
  int _start = 10;
  Future<void>? _initializeControllerFuture;
  String title = "";
  String description = "";
  String language = "";
  bool enableVideo = true;
  Set<String> tempFiles = {};

  @override
  void initState() {
    _initializeController();
    _initializeControllerFuture;
    _initializeData();
    super.initState();
  }

  Future<void> _initializeController() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    _initializeControllerFuture = _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) async {
      superPrint(e);
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        Get.back();
        Get.showSnackbar(const GetSnackBar(
          message:
              "Phluid does not has permission to access your camera. Please go to setting and enable permission for camera access to Phluid app, try again.",
          duration: Duration(seconds: 3),
        ));
      });
    });
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _toggleCamera() async {
    cameras = await availableCameras();
    final CameraDescription newCameraDescription =
        (_cameraController!.description == cameras[0])
            ? cameras[1]
            : cameras[0];

    if (_cameraController != null) {
      await _cameraController!.dispose();
    }
    _cameraController =
        CameraController(newCameraDescription, ResolutionPreset.max);
    _initializeControllerFuture = _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) async {
      superPrint(e);
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        Get.back();
        Get.showSnackbar(const GetSnackBar(
          message:
              "Phluid does not has permission to access your camera. Please go to setting and enable permission for camera access to Phluid app, try again.",
          duration: Duration(seconds: 3),
        ));
      });
    });

    setState(() {});
  }

  void _initializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
      title = Get.parameters['title'] ?? '';
      description = Get.parameters['description'] ?? '';
      language = Get.parameters['language'] ?? '';
      enableVideo = Get.parameters['enableVideo'] != 'false';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController!.dispose();
    _timer!.cancel();
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          enableVideo
              ? "${StringConst.cameraText} ${_start != 0 ? '($_start sec)' : ''}"
              : StringConst.cameraText,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
        actions: const [],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: _getAppBar,
        body: Builder(
            builder: (BuildContext bodyContext) => SizedBox(
                  height: MediaQuery.of(bodyContext).size.height,
                  child: Stack(
                    children: [
                      _cameraController == null ||
                              !_cameraController!.value.isInitialized
                          ? const Center(child: CircularProgressIndicator())
                          : _cameraController!.description.lensDirection ==
                                  CameraLensDirection.front
                              ? Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(pi),
                                  child: CameraPreview(_cameraController!))
                              : CameraPreview(_cameraController!),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        flash
                                            ? Icons.flash_on
                                            : Icons.flash_off,
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
                                    onLongPress: enableVideo
                                        ? () async {
                                            startTimer();
                                            await _cameraController!
                                                .startVideoRecording();
                                            setState(() {
                                              isRecoring = true;
                                            });
                                          }
                                        : null,
                                    onLongPressUp: enableVideo
                                        ? () => _lognPressUp()
                                        : null,
                                    onTap: () {
                                      if (!isRecoring) takePhoto(context);
                                    },
                                    child: isRecoring
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
                                          // transform = transform + pi;
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )));
  }

  Future<void> takePhoto(BuildContext context) async {
    XFile file = await _cameraController!.takePicture();
    Get.toNamed(imageViewPageRoute, parameters: {
      'path': file.path,
      'preview': 'false',
      'route': route,
      'type': 'assets',
      'tempFiles': Get.parameters['tempFiles'] ?? '',
      'title': title,
      'description': description,
      'language': language,
    });
  }

  Future<void> _lognPressUp() async {
    XFile videopath = await _cameraController!.stopVideoRecording();
    setState(() {
      isRecoring = false;
    });
    Get.toNamed(videoViewPageRoute, parameters: {
      'path': videopath.path,
      'preview': 'false',
      'route': route,
      'tempFiles': Get.parameters['tempFiles'] ?? '',
      'title': title,
      'description': description,
      'language': language,
    });
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
          _lognPressUp();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
