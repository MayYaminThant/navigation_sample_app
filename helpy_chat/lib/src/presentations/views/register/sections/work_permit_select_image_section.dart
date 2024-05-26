part of '../../views.dart';

class WorkPermitSelectImageSection extends StatefulWidget {
  const WorkPermitSelectImageSection({Key? key}) : super(key: key);

  @override
  State<WorkPermitSelectImageSection> createState() =>
      _WorkPermitSelectImageSectionState();
}

enum SelectionState { selecting, cropping, doingOcr, ocrSuccess, ocrFail }

class _WorkPermitSelectImageSectionState
    extends State<WorkPermitSelectImageSection> {
  bool _isFront = true;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  late String _selectedPhotoPath;
  String? _croppedPhotoPath;
  WorkPermitDetails? _parsedWorkPermit;
  SelectionState state = SelectionState.selecting;

  @override
  void initState() {
    super.initState();
    _readGetData();
  }

  void _readGetData() {
    setState(() {
      _isFront = Get.arguments["isFront"];
      _selectedPhotoPath = Get.arguments["photoPath"];
    });
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
      title: Text(
          _isFront ? "Front of Work Permit".tr : "Back of Work Permit".tr,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
      leadingWidth: 52,
      elevation: 0.0,
      titleSpacing: 20,
      actions: [
        if (state == SelectionState.selecting)
          IconButton(
              icon: const Icon(
                Icons.image,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () async {
                final imagePath = await _pickImage();
                if (imagePath != null) {
                  setState(() {
                    _selectedPhotoPath = imagePath;
                  });
                }
              }),
        const SizedBox(
          width: 10,
        )
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _photoView(),
          )),
    );
  }

  Widget _photoView() {
    return SafeArea(
        child: Stack(
      children: [
        Center(
            child: Image.file(File(_croppedPhotoPath ?? _selectedPhotoPath))),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            state == SelectionState.ocrSuccess
                ? _getOcrSuccessText
                : state == SelectionState.ocrFail
                    ? _getOcrFailText
                    : Container(),
            Container(),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: state == SelectionState.ocrSuccess
                    ? _getOcrSuccessActions
                    : state == SelectionState.ocrFail
                        ? _getOcrFailActions
                        : _getCroppingActions),
          ],
        ),
        if (state == SelectionState.doingOcr ||
            state == SelectionState.cropping)
          Expanded(
              child: Container(
            color: const Color.fromARGB(200, 0, 0, 0),
          )),
        if (state == SelectionState.doingOcr ||
            state == SelectionState.cropping)
          const Center(
              child: SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator()))
      ],
    ));
  }

  Widget get _getOcrSuccessText => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            children: [
              Text("Success!".tr,
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              Text(
                "Your photo looks good!\n You can proceed, or choose a new photo."
                    .tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w300),
              )
            ],
          )));

  Widget get _getOcrFailText => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            children: [
              Text("Unable to Find Work Permit".tr,
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              Text(
                "Please adjust the photo crop,\nor choose a new photo.".tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w300),
              )
            ],
          )));

  Widget get _getOcrSuccessActions => Row(
        children: [
          Expanded(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 55),
                  child: CustomOutlineButton(
                      fontSize: 18,
                      text: "Try again".tr,
                      onPressed: state == SelectionState.ocrSuccess
                          ? () {
                              _retry();
                            }
                          : null))),
          const SizedBox(width: 20),
          Expanded(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 55),
                  child: CustomPrimaryButton(
                    fontSize: 18,
                    text: "Proceed".tr,
                    onPressed: state == SelectionState.ocrSuccess
                        ? () {
                            _submit();
                          }
                        : null,
                  ))),
        ],
      );

  Widget get _getOcrFailActions => Row(
        children: [
          Expanded(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 55),
                  child: CustomPrimaryButton(
                    fontSize: 18,
                    text: "Try again".tr,
                    onPressed: state == SelectionState.ocrFail
                        ? () {
                            _retry();
                          }
                        : null,
                  ))),
        ],
      );

  Widget get _getCroppingActions => Row(
        children: [
          Expanded(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 55),
                  child: CustomOutlineButton(
                      fontSize: 18,
                      text: "Crop Photo".tr,
                      onPressed: state == SelectionState.selecting
                          ? () {
                              _initiateCrop();
                            }
                          : null))),
          const SizedBox(width: 20),
          Expanded(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 55),
                  child: CustomPrimaryButton(
                    fontSize: 18,
                    text: "Confirm Photo".tr,
                    onPressed: state == SelectionState.selecting
                        ? () {
                            _confirmPhoto();
                          }
                        : null,
                  ))),
        ],
      );

  void _retry() {
    setState(() {
      _croppedPhotoPath = null;
      state = SelectionState.selecting;
    });
  }

  void _confirmPhoto() async {
    setState(() {
      state = SelectionState.doingOcr;
    });
    final success =
        await _processImage(_croppedPhotoPath ?? _selectedPhotoPath);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (success) {
      setState(() {
        state = SelectionState.ocrSuccess;
      });
    } else {
      setState(() {
        state = SelectionState.ocrFail;
      });
    }
  }

  void _initiateCrop() async {
    setState(() {
      state = SelectionState.cropping;
    });
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _selectedPhotoPath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Work Permit'.tr,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            // initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Work Permit'.tr,
        ),
      ],
    );
    setState(() {
      state = SelectionState.selecting;
      _croppedPhotoPath = croppedFile?.path;
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

  Future<bool> _processImage(String filePath) async {
    late InputImage inputImage;
    try {
      inputImage = InputImage.fromFilePath(filePath);
    } catch (e) {
      return false;
    }

    _parsedWorkPermit = await _parseWorkPermit(inputImage);
    if (_parsedWorkPermit == null) {
      return false;
    }

    setState(() {
      if (_isFront) {
        _parsedWorkPermit!.frontImagePath = filePath;
        _parsedWorkPermit!.frontImageThumbnail = filePath;
      } else {
        _parsedWorkPermit!.backImagePath = filePath;
        _parsedWorkPermit!.backImageThumbnail = filePath;
      }
    });
    return true;
  }

  void _submit() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    if (_parsedWorkPermit == null) {
      return;
    }
    candidateBloc.mergeNewWorkPermit(_parsedWorkPermit!, isFront: _isFront);
    candidateBloc.add(WorkPermitPhotoTaken());
    Get.back();
  }

  Future<WorkPermitDetails?> _parseWorkPermit(InputImage inputImage) async {
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    // initial check
    if (!_recognizedTextContains(
        _isFront ? frontStrings : backStrings, recognizedText)) {
      return null;
    }

    if (_isFront) return WorkPermitDetails();

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

  bool _recognizedTextContains(
      List<String> strings, RecognizedText recognizedText) {
    final checkText = recognizedText.text.toUpperCase();
    for (final toCheck in strings) {
      final upperCheck = toCheck.toUpperCase();
      if (!checkText.contains(upperCheck)) return false;
    }
    return true;
  }

  Future<String?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? media = await picker.pickImage(source: ImageSource.gallery);
    if (media == null) return null;
    final mediaFile = File(media.path);
    final CompressReturn compressReturn =
        await ImageUtils.compressMediaFile(mediaFile);
    if (compressReturn.file == null) {
      showErrorSnackBar("${compressReturn.message}");
      return null;
    }
    return compressReturn.file!.path;
  }
}
