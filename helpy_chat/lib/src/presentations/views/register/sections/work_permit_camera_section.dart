part of '../../views.dart';

class WorkPermitCameraSection extends StatefulWidget {
  const WorkPermitCameraSection({Key? key}) : super(key: key);

  @override
  State<WorkPermitCameraSection> createState() =>
      _WorkPermitCameraSectionState();
}

class _WorkPermitCameraSectionState extends State<WorkPermitCameraSection> {
  CameraDescription? frontCamera;
  CameraController? _cameraController;
  bool flash = false;
  Future<void>? _initializeCameraControllerFuture;
  bool _isFront = true;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  Rect? cropRect;
  int successCount = 0;
  bool showTryAgain = false;

  WorkPermitDetails? parsedWorkPermit;

  bool processingImage = false;

  @override
  void initState() {
    super.initState();
    _readFrontOrBack();
    _initializeController();
    _initializeCameraControllerFuture;
  }

  void _readFrontOrBack() {
    setState(() {
      _isFront = Get.arguments;
    });
  }

  Future<void> _initializeController() async {
    final cameras = await availableCameras();
    frontCamera = (cameras).firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras[0]);
    if (frontCamera == null) {
      Get.back();
      Get.showSnackbar(const GetSnackBar(
        message: "Error accessing your camera, please try again.",
        duration: Duration(seconds: 3),
      ));
    }
    _cameraController = CameraController(
      frontCamera!, ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21 // for Android
          : ImageFormatGroup.bgra8888, // for iOS
    );
    _initializeCameraControllerFuture =
        _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      _cameraController!.setFlashMode(FlashMode.off);
      _cameraController!.startImageStream((CameraImage availableImage) async {
        cropRect ??= _calculateCropRect(availableImage);
        _imageCaptured(availableImage);
        // _testImage(availableImage);
      });
    }).catchError((Object e) async {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        Get.back();
        Get.showSnackbar(const GetSnackBar(
          message:
              "Phluid Helpy does not has permission to access your camera. Please allow Phluid Helpy access to you camera in your phone settings, and try again.",
          duration: Duration(seconds: 3),
        ));
      });
    });
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    if (_cameraController != null) {
      _cameraController!.dispose();
    }
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.black,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      leadingWidth: 52,
      elevation: 0.0,
      titleSpacing: 0.0,
      actions: [
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
                  ? _cameraController!.setFlashMode(FlashMode.torch)
                  : _cameraController!.setFlashMode(FlashMode.off);
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      availableBack: false,
      onWillPop: () async {
        Get.back();
        return false;
      },
      scaffold: Scaffold(
          backgroundColor: Colors.black,
          appBar: _getAppBar,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: (_isFront && parsedWorkPermit?.frontImagePath == null) ||
                    (!_isFront && parsedWorkPermit?.backImagePath == null)
                ? _takingPhotoView()
                : _reviewPhotoView(),
          )),
    );
  }

  Widget _reviewPhotoView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            const SizedBox(height: 10),
            Image.file(File((_isFront
                    ? parsedWorkPermit?.frontImagePath
                    : parsedWorkPermit?.backImagePath) ??
                ''))
          ],
        ),
        ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black, backgroundBlendMode: BlendMode.dstOut),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  height: (MediaQuery.of(context).size.width - 30) * 17 / 27,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  height: (MediaQuery.of(context).size.width - 30) * 17 / 27,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Success!".tr,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
                const SizedBox(height: 6),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Your photo looks good!\n You can proceed, or re-take the photo."
                          .tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    )),
              ],
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 55),
                          child: CustomOutlineButton(
                              fontSize: 18,
                              text: "Try again".tr,
                              onPressed: () {
                                _retakePhoto();
                              }))),
                  const SizedBox(width: 20),
                  Expanded(
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 55),
                          child: CustomPrimaryButton(
                            fontSize: 18,
                            text: "Confirm".tr,
                            onPressed: () {
                              _submit();
                            },
                          ))),
                ],
              )
            ]))
      ],
    );
  }

  Widget _takingPhotoView() {
    return _cameraController == null || !_cameraController!.value.isInitialized
        ? const Center(child: CircularProgressIndicator())
        : _cameraView();
  }

  Widget _cameraView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(_cameraController!),
        ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black, backgroundBlendMode: BlendMode.dstOut),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  height: (MediaQuery.of(context).size.width - 30) * 17 / 27,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  height: (MediaQuery.of(context).size.width - 30) * 17 / 27,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _isFront
                      ? "Front of Work Permit".tr
                      : "Back of Work Permit".tr,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(height: 6),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _isFront
                          ? "Fit the FRONT of your Work Permit within the frame.\nMake sure the photo is clear."
                              .tr
                          : "Fit the BACK of your Work Permit within the frame.\nMake sure the photo is clear."
                              .tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    )),
                const SizedBox(
                  height: 45,
                ),
                if (showTryAgain && successCount != 1)
                  Text(
                    "Try again".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                if (successCount == 1) const CircularProgressIndicator(),
                const SizedBox(height: 8),
                if (successCount == 1)
                  Text(
                    "Hold still".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )
              ],
            )),
      ],
    );
  }

  void _retakePhoto() {
    setState(() {
      successCount = 0;
      showTryAgain = false;
      processingImage = false;
      parsedWorkPermit = null;
    });
  }

  static const frontStrings = [
    'PERMIT',
    'WORK',
    'Employment',
    'Singapore',
    'Name',
    'Sector',
    'DOMESTIC'
  ];
  static const backStrings = [
    'VISIT',
    'PASS',
    'Regulations',
    'Name',
    'Nationality',
    'status',
    'VISA'
  ];

  /// this function is triggered whenever a new frame is available from the camera.
  Future<void> _imageCaptured(CameraImage cameraImage) async {
    if (processingImage) return;
    processingImage = true;
    final success = await _processImage(cameraImage);
    if (success) return;
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    if (successCount == 1) {
      await Future.delayed(const Duration(milliseconds: 1500));
    }
    processingImage = false;
  }

  Future<bool> _processImage(CameraImage cameraImage) async {
    final inputImage = inputImageFromCameraImage(
        cameraImage, frontCamera!, _cameraController!);
    if (inputImage == null) {
      return false;
    }

    if (successCount < 1) {
      parsedWorkPermit = await _parseWorkPermit(inputImage, true);
      if (parsedWorkPermit == null) {
        return false;
      }
      if (mounted) {
        setState(() {
          successCount++;
          showTryAgain = true;
        });
      }
      return false;
    }

    parsedWorkPermit = await _parseWorkPermit(inputImage, false);
    if (parsedWorkPermit == null) {
      if (mounted) {
        setState(() {
          successCount = 0;
        });
      }
      return false;
    }

    final imagePath = await _saveImage(inputImage);
    if (imagePath == null) {
      return false;
    }
    final CompressReturn compressReturn =
        await ImageUtils.compressMediaFile(File(imagePath));
    if (compressReturn.file == null) {
      showErrorSnackBar("${compressReturn.message}");
      return false;
    }
    final String compressedImagePath = compressReturn.file!.path;

    final thumbnailPath = await _saveImage(inputImage, crop: cropRect);
    if (thumbnailPath == null) {
      return false;
    }
    final CompressReturn compressReturnThumbnail =
        await ImageUtils.compressMediaFile(File(thumbnailPath));
    if (compressReturnThumbnail.file == null) {
      showErrorSnackBar("${compressReturn.message}");
      return false;
    }
    final String compressedThumbnailPath = compressReturnThumbnail.file!.path;
    setState(() {
      successCount = 2;
      if (_isFront) {
        parsedWorkPermit!.frontImagePath = compressedImagePath;
        parsedWorkPermit!.frontImageThumbnail = compressedThumbnailPath;
      } else {
        parsedWorkPermit!.backImagePath = compressedImagePath;
        parsedWorkPermit!.backImageThumbnail = compressedThumbnailPath;
      }
    });
    return true;
  }

  Rect _calculateCropRect(CameraImage image) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = min(image.width, image.height) /
        screenWidth; // multiply screen width by scaleFactor to get image width
    final windowWidthScreen = (screenWidth - 30);
    final windowHeightScreen = windowWidthScreen * 17 / 27;
    const topOffsetScreen = 100;
    const leftOffsetScreen = 15;
    final r = Rect.fromLTWH(
        leftOffsetScreen * scaleFactor,
        topOffsetScreen * scaleFactor,
        windowWidthScreen * scaleFactor,
        windowHeightScreen * scaleFactor);
    return r;
  }

  void _submit() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    if (parsedWorkPermit == null) {
      return;
    }
    candidateBloc.mergeNewWorkPermit(parsedWorkPermit!, isFront: _isFront);
    candidateBloc.add(WorkPermitPhotoTaken());
    Get.back();
  }

  Future<String?> _saveImage(InputImage inputImage, {Rect? crop}) async {
    imglib.Image? bitmap = decodeYUV420SP(inputImage);
    if (bitmap == null) {
      return null;
    }

    if (crop != null) {
      bitmap = imglib.copyCrop(bitmap,
          x: crop.left.floor(),
          y: crop.top.floor(),
          width: crop.width.floor(),
          height: crop.height.floor());
    }

    final tempPath = (await getTemporaryDirectory()).path;
    const uuid = Uuid();
    final newFileName = uuid.v4();
    final filePath = '$tempPath/$newFileName.JPG';
    await File(filePath).writeAsBytes(imglib.encodeJpg(bitmap));
    return filePath;
  }

  Future<WorkPermitDetails?> _parseWorkPermit(
      InputImage inputImage, bool brief) async {
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    // initial check
    if (cropRect == null) return null;
    double imageWidth = 720;
    if (inputImage.metadata != null) {
      imageWidth = min(
          inputImage.metadata!.size.width, inputImage.metadata!.size.height);
    }
    if (!_recognizedTextContains(
        _isFront
            ? brief
                ? [frontStrings.first]
                : frontStrings
            : brief
                ? [backStrings.first]
                : backStrings,
        recognizedText,
        cropRect!,
        imageWidth)) {
      return null;
    }

    if (_isFront || brief) return WorkPermitDetails();

    String text = recognizedText.text.toUpperCase();
    // read FIN
    final fin = _findFin(text);
    final birthday = _findBirthday(text);
    if (fin == null || birthday == null) return null;
    return WorkPermitDetails(fin: fin, birthday: birthday);
  }

  final birthdayRegexp = RegExp(r'\d{2}-\d{2}-\d{4}');

  DateTime? _findBirthday(String allText) {
    final birthdayAllText = allText
        .replaceAll('O', '0')
        .replaceAll('D', '0')
        .replaceAll('Q', '0')
        .replaceAll('L', '1')
        .replaceAll('I', '1');

    final List<DateTime> birthdayOptions = [];
    final birthdayMatches = birthdayRegexp.allMatches(birthdayAllText);
    for (final birthdayMatch in birthdayMatches) {
      final validBirthday = _validateBirthdayText(birthdayMatch.group(0) ?? '');
      if (validBirthday != null) {
        birthdayOptions.add(validBirthday);
      }
    }
    if (birthdayOptions.isEmpty) {
      return null;
    }
    return birthdayOptions.reduce(
        (min, e) => e.isBefore(min) ? e : min); // return the earliest date
  }

  final currentYear = DateTime.now().year;

  DateTime? _validateBirthdayText(String birthday) {
    final birthdayParts = birthday.split('-');
    if (int.parse(birthdayParts[0]) > 31) return null;
    if (int.parse(birthdayParts[1]) > 12) return null;
    final year = int.parse(birthdayParts[2]);
    if (year < 1800 || year > currentYear) return null;
    return DateTime.parse(
        '$year-${birthdayParts[1]}-${birthdayParts[0]}'); //format: yyyy-mm-dd
  }

  final finRegexp = RegExp(r'[FGM][o\d]{7}[XWUTRQPNMLK]');

  String? _findFin(String allText) {
    final finAllText = allText.replaceAll('O', '0').replaceAll('I', '1');
    final finMatches = finRegexp.allMatches(finAllText);
    for (final finMatch in finMatches) {
      final validFin = _validateFin(finMatch.group(0) ?? '');
      if (validFin != null) {
        return validFin;
      }
    }
    return null;
  }

  static const checksumLetters = [
    'X',
    'W',
    'U',
    'T',
    'R',
    'Q',
    'P',
    'N',
    'M',
    'L',
    'K'
  ];
  static const multiplyFactors = [2, 7, 6, 5, 4, 3, 2];

  String? _validateFin(String fin) {
    if (fin.length != 9) return null;
    if (fin[0] != 'F' && fin[0] != 'G' && fin[0] != 'M') return null;
    final digits = fin.substring(1, 8);
    final currentChecksum = fin[8];
    final sumOffset = fin[0] == 'G'
        ? 4
        : fin[0] == 'M'
            ? 3
            : 0;
    final sum = sumOffset +
        digits
            .split('')
            .map((d) => int.parse(d))
            .toList()
            .asMap()
            .entries
            .map((entry) => entry.value * multiplyFactors[entry.key])
            .sum;
    final expectedChecksum = checksumLetters[sum % 11];
    if (currentChecksum == expectedChecksum) {
      return fin;
    }
    return null;
  }

  bool _recognizedTextContains(List<String> strings,
      RecognizedText recognizedText, Rect crop, double imageWidth) {
    for (final toCheck in strings) {
      final upperCheck = toCheck.toUpperCase();

      var found = false;
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          // origin is top right
          final screenSpaceLeft = imageWidth - line.boundingBox.left;
          final screenSpaceRight = imageWidth - line.boundingBox.right;
          if (line.text.toUpperCase().contains(upperCheck) &&
              screenSpaceLeft > crop.left &&
              screenSpaceLeft < crop.right &&
              screenSpaceRight > crop.left &&
              screenSpaceRight < crop.right &&
              line.boundingBox.top > crop.top &&
              line.boundingBox.top < crop.bottom &&
              line.boundingBox.bottom > crop.top &&
              line.boundingBox.bottom < crop.bottom) {
            found = true;
            break;
          }
        }
        if (found) {
          break;
        }
      }

      if (!found) return false;
    }
    return true;
  }
}
