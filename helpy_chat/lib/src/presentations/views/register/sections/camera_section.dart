// part of '../../views.dart';

// class CameraSection extends StatefulWidget {
//   const CameraSection({Key? key}) : super(key: key);

//   @override
//   State<CameraSection> createState() => _CameraSectionState();
// }

// class _CameraSectionState extends State<CameraSection> {
//   List<CameraDescription> cameras = [];
//   CameraController? _cameraController;
//   bool isRecoring = false;
//   bool flash = false;
//   double transform = 0;
//   Timer? _timer;
//   int _start = 10;
//   Future<void>? _initializeControllerFuture;
//   String route = "";

//   @override
//   void initState() {
//     initialData();
//     _initializeController();
//     _initializeControllerFuture;
//     super.initState();
//   }

//   void initialData() {
//     setState(() {
//       route = Get.parameters['route'] ?? '';
//     });
//   }

//   Future<void> _initializeController() async {
//     cameras = await availableCameras();
//     _cameraController = CameraController(cameras[0], ResolutionPreset.max);
//     _initializeControllerFuture = _cameraController!.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) async {
//       superPrint(e);
//       await Future.delayed(const Duration(seconds: 2));
//       setState(() {
//         Get.back();
//         Get.showSnackbar(const GetSnackBar(
//           message:
//               "Phluid does not has permission to access your camera. Please go to setting and enable permission for camera access to Phluid app, try again.",
//           duration: Duration(seconds: 3),
//         ));
//       });
//     });
//     if (!mounted) {
//       return;
//     }
//     setState(() {});
//   }

//   Future<void> _toggleCamera() async {
//     cameras = await availableCameras();
//     final CameraDescription newCameraDescription =
//         (_cameraController!.description == cameras[0])
//             ? cameras[1]
//             : cameras[0];

//     if (_cameraController != null) {
//       await _cameraController!.dispose();
//     }
//     _cameraController =
//         CameraController(newCameraDescription, ResolutionPreset.max);
//     _initializeControllerFuture = _cameraController!.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) async {
//       superPrint(e);
//       await Future.delayed(const Duration(seconds: 2));
//       setState(() {
//         Get.back();
//         Get.showSnackbar(const GetSnackBar(
//           message:
//               "Phluid does not has permission to access your camera. Please go to setting and enable permission for camera access to Phluid app, try again.",
//           duration: Duration(seconds: 3),
//         ));
//       });
//     });

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _closeFunction();
//     super.dispose();
//   }

//   void _closeFunction() {
//     if (_cameraController != null) {
//       _cameraController!.dispose();
//     }
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//   }

//   AppBar get _getAppBar {
//     final articleBloc = BlocProvider.of<ArticleBloc>(context);
//     return AppBar(
//       backgroundColor: Colors.black,
//       leading: GestureDetector(
//         onTap: () => Get.offAllNamed(route),
//         child: const Icon(
//           Iconsax.arrow_left,
//           color: AppColors.white,
//         ),
//       ),
//       leadingWidth: 52,
//       title: Text(
//         articleBloc.isOnlyPhoto
//             ? StringConst.cameraText
//             : "${StringConst.cameraText} ${_start != 0 ? '($_start sec)' : ''}",
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//             color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w100),
//       ),
//       elevation: 0.0,
//       titleSpacing: 0.0,
//       centerTitle: true,
//       actions: const [],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final articleBloc = BlocProvider.of<ArticleBloc>(context);
//     return BackgroundScaffold(
//       availableBack: false,
//       onWillPop: () async {
//         Get.offAllNamed(route);
//         return false;
//       },
//       scaffold: Scaffold(
//           backgroundColor: Colors.black,
//           appBar: _getAppBar,
//           body: SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: Stack(
//               children: [
//                 _cameraController == null ||
//                         !_cameraController!.value.isInitialized
//                     ? const Center(child: CircularProgressIndicator())
//                     : _cameraController!.description.lensDirection ==
//                             CameraLensDirection.front
//                         ? Transform(
//                             alignment: Alignment.center,
//                             transform: Matrix4.rotationY(pi),
//                             child: CameraPreview(_cameraController!))
//                         : CameraPreview(_cameraController!),
//                 Positioned(
//                   bottom: 0.0,
//                   child: Container(
//                     color: Colors.black,
//                     width: MediaQuery.of(context).size.width,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             IconButton(
//                                 icon: Icon(
//                                   flash ? Icons.flash_on : Icons.flash_off,
//                                   color: Colors.white,
//                                   size: 28,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     flash = !flash;
//                                   });
//                                   flash
//                                       ? _cameraController!
//                                           .setFlashMode(FlashMode.torch)
//                                       : _cameraController!
//                                           .setFlashMode(FlashMode.off);
//                                 }),
//                             GestureDetector(
//                               onLongPress: () async {
//                                 if (!articleBloc.isOnlyPhoto) {
//                                   startTimer();
//                                   await _cameraController!
//                                       .startVideoRecording();
//                                   setState(() {
//                                     isRecoring = true;
//                                   });
//                                 }
//                               },
//                               onLongPressUp: () => _lognPressUp(),
//                               onTap: () {
//                                 if (!isRecoring) takePhoto(context);
//                               },
//                               child: isRecoring
//                                   ? const Icon(
//                                       Icons.radio_button_on,
//                                       color: Colors.red,
//                                       size: 80,
//                                     )
//                                   : const Icon(
//                                       Icons.panorama_fish_eye,
//                                       color: Colors.white,
//                                       size: 70,
//                                     ),
//                             ),
//                             IconButton(
//                                 icon: Transform.rotate(
//                                   angle: transform,
//                                   child: const Icon(
//                                     Icons.flip_camera_ios,
//                                     color: Colors.white,
//                                     size: 28,
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _toggleCamera();
//                                     // transform = transform + pi;
//                                   });
//                                 }),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }

//   Future<void> takePhoto(BuildContext context) async {
//     XFile file = await _cameraController!.takePicture();
//     if (context.mounted) {
//       final articleBloc = BlocProvider.of<ArticleBloc>(context);
//       articleBloc.tempData = file.path;
//       Get.toNamed(imageViewPageRoute,
//           parameters: {"route": route, "preview": "false"});
//     }
//   }

//   Future<void> _lognPressUp() async {
//     setState(() {
//       isRecoring = false;
//     });
//     final articleBloc = BlocProvider.of<ArticleBloc>(context);
//     if (!articleBloc.isOnlyPhoto) {
//       final XFile file = await _cameraController!.stopVideoRecording();
//       articleBloc.tempData = file.path;
//       Get.offNamed(videoViewPageRoute,
//           parameters: {"route": route, "preview": "false"});
//     }
//   }

//   void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (_start == 0) {
//           setState(() {
//             timer.cancel();
//           });
//           _lognPressUp();
//         } else {
//           setState(() {
//             _start--;
//           });
//         }
//       },
//     );
//   }
// }
