part of '../../views.dart';

class ArticleCreateSection extends StatefulWidget {
  const ArticleCreateSection({super.key});

  @override
  State<ArticleCreateSection> createState() => _ArticleCreateSectionState();
}

class _ArticleCreateSectionState extends State<ArticleCreateSection> {
  final ConfigLanguage defaultLanguage =
      const ConfigLanguage(language: "English", languageName: "English");
  late ConfigLanguage selectedValue;
  Map? candidateData;
  List<Widget> imageWidgetList = [];
  List<ConfigLanguage> languageList = [];
  ArticleDetail? articleDetail;
  bool isUploading = false;
  Set<String> tempFilesSet = {};
  String title = "";
  String description = "";

  @override
  void initState() {
    selectedValue = defaultLanguage;
    _getCandidateData();
    _getLanguageData();
    super.initState();
  }

  void changeUploading(bool value) {
    setState(() {
      if (value) {
        Loading.showLoading(message: StringConst.loadingText);
      } else {
        _closeKeyboardIfOpen();
        Loading.cancelLoading();
      }
      isUploading = value;
    });
  }

  //Language Data List with top Countries
  void _getLanguageData() async {
    List<ConfigLanguage> dataList = List<ConfigLanguage>.from(
      (await DBUtils.getKeyDataList(ConfigsKeyHelper.firstTimeLoadLanguageKey))
          .map((e) => ConfigLanguageModel.fromJson(e)),
    );

    setState(() {
      languageList.addAll(dataList);
      selectedValue = languageList.singleWhere(
        (element) =>
            element.language == (Get.parameters['language'] ?? "English"),
        orElse: () => defaultLanguage,
      );
    });
  }

  void _getTempImages() {
    imageWidgetList.clear();
    for (var element in tempFilesSet) {
      imageWidgetList.add(Row(
        key: ValueKey(element),
        children: [
          GestureDetector(
            onTap: () => _showTempActionModal(element),
            child: _getTempImageView(element),
          ),
        ],
      ));
    }
  }

  void showAlertLimitCharModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogSimple(
          message: StringConst.charLimit,
          positiveText: 'OK',
          onButtonClick: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _requestcreateArticle() {
    setState(() {
      isUploading = true;
    });
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesCreateRequestParams params = ArticlesCreateRequestParams(
        token: candidateData!['token'],
        title: title,
        content: description,
        images: tempFilesSet.isNotEmpty
            ? List<File>.generate(tempFilesSet.length,
                (int index) => File(tempFilesSet.toList()[index]))
            : null,
        language: selectedValue.language);
    articleBloc.add(ArticlesCreateRequested(params: params));
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.candidateTableName);
    final String lang = box.get(DBUtils.language) ?? 'English';
    selectedValue = languageList.singleWhere(
        (element) => element.language == lang,
        orElse: () => defaultLanguage);
    if (data != null) {
      candidateData = data;
    }
  }

  void _closeKeyboardIfOpen() {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: isUploading
          ? () async {
              return false;
            }
          : () async {
              Get.offNamed(articlesListPageRoute);
              return false;
            },
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus == null
                ? null
                : FocusManager.instance.primaryFocus!.unfocus(),
            child: _getArticleCreateScaffold),
      ),
    );
  }

  Scaffold get _getArticleCreateScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: _getListArticleCreate,
    );
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: isUploading
            ? null
            : () {
                Get.toNamed(articlesListPageRoute);
              },
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      leadingWidth: 52,
      title: Text(
        StringConst.createArticle.tr,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      actions: const [],
    );
  }

  Widget get _getListArticleCreate {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.padding20,
            vertical: Sizes.padding20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //_getArticleHeaderAddPhotos,
              _getImageUploadContainer,
              const SizedBox(
                height: 20,
              ),
              _getArticleAddTitleForm,
              const SizedBox(
                height: 20,
              ),
              _getArticleDescription,
              const SizedBox(
                height: 20,
              ),
              _getLanguage,
              const SizedBox(
                height: 20,
              ),
              _getButtonPostArticle,
            ],
          )),
    );
  }

  Widget get _getArticleAddTitleForm {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
            border: const GradientBoxBorder(
              gradient: LinearGradient(colors: [
                Color(0xFFFFB6A0),
                Color(0xFFA5E3FD),
                Color(0xFF778AFF),
                Color(0xFFFFCBF2),
              ]),
              width: 1,
            ),
          ),
          child: TextFormField(
            maxLength: 50,
            style: const TextStyle(color: AppColors.white, fontSize: 14),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            initialValue: title,
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
            decoration: InputDecoration(
              hintText:
                  '${StringConst.articleTitle.tr} \n ${StringConst.titleDetail.tr}',
              hintStyle:
                  const TextStyle(fontSize: 12, color: AppColors.secondaryGrey),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              counterStyle: GoogleFonts.poppins(
                  fontSize: 12, color: AppColors.secondaryGrey),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _getArticleDescription {
    return Stack(
      children: [
        Container(
          height: 260,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
            border: const GradientBoxBorder(
              gradient: LinearGradient(colors: [
                Color(0xFFFFB6A0),
                Color(0xFFA5E3FD),
                Color(0xFF778AFF),
                Color(0xFFFFCBF2),
              ]),
              width: 1,
            ),
          ),
          child: TextFormField(
            onChanged: (value) {
              if (value.length >= kCommentCharacterLimitation) {
                showAlertLimitCharModal();
              } else {
                setState(() {
                  description = value;
                });
              }
            },
            style: const TextStyle(color: AppColors.white, fontSize: 14),
            maxLines: null,
            maxLength: 8000,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            keyboardType: TextInputType.multiline,
            initialValue: description,
            inputFormatters: [
              LengthLimitingTextInputFormatter(kCommentCharacterLimitation),
            ],
            decoration: InputDecoration(
              hintText:
                  '${StringConst.articleDescription.tr}\n${StringConst.articleDetaile.tr}',
              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              border: InputBorder.none,
              filled: true,
              counter: const Text(''),
              fillColor: Colors.transparent,
            ),
          ),
        ),
        Positioned(
            bottom: 17,
            right: 17,
            child: Text("${description.length}/8000",
                style: GoogleFonts.poppins(
                    fontSize: 12, color: AppColors.secondaryGrey)))
      ],
    );
  }

  Widget get _getButtonPostArticle {
    return BlocConsumer<ArticleBloc, ArticleState>(
      builder: (_, state) {
        return CustomPrimaryButton(
          text: StringConst.postArticle,
          onPressed: isUploading || !_filledRequiredFields
              ? null
              : () => _verifyFields(),
          fontSize: 15,
          widthButton: MediaQuery.of(context).size.width,
          customColor:
              _filledRequiredFields ? AppColors.primaryColor : Colors.grey,
        );
      },
      listener: (_, state) {
        if (state is ArticlesCreateLoading) {
          changeUploading(true);
        }
        if (state is ArticlesCreateSuccess) {
          changeUploading(false);
          Get.offNamed(articlesListPageRoute);
          showSuccessSnackBar(state.articleData.data!['message']);
          imageWidgetList.clear();
        }

        if (state is ArticlesCreateFail) {
          changeUploading(false);
          showErrorSnackBar(state.message);
        }
      },
    );
  }

  bool get _filledRequiredFields {
    return title.isNotEmpty &&
        description.isNotEmpty &&
        tempFilesSet.isNotEmpty;
  }

  Future<void> _verifyFields() async {
    if (title.isEmpty) {
      showErrorSnackBar('Please enter the Article Title.');
    } else if (description.isEmpty) {
      showErrorSnackBar('Please enter the Article Description.');
    } else if (description.length > kCommentCharacterLimitation) {
      showAlertLimitCharModal();
    } else if (tempFilesSet.isEmpty) {
      showErrorSnackBar('Please Add your photos.');
    } else {
      if (isUploading) {
        return;
      }
      _requestcreateArticle();
    }
  }

  Future<String?> generateAndUploadThumbnail(File file) async {
    String? thumbnailPath = "";
    const List<String> videoFormats = ['mp4', 'mov', 'avi'];
    final String fileExtension = file.path.split('.').last.toLowerCase();
    final bool isVideo = videoFormats.contains(fileExtension);
    if (isVideo) {
      thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: file.path,
        maxWidth: 128,
        quality: 25,
      );
    } else {
      thumbnailPath = file.path;
    }
    return thumbnailPath;
  }

  static Future<File?> openUploadPreview(
      {required BuildContext context,
      required File file,
      required bool isPreview,
      required bool isVideo}) async {
    return showDialog<File?>(
      context: context,
      builder: (BuildContext context) {
        return UploadPreview(
          originalFile: file,
          preview: isPreview,
          isVideo: isVideo,
        );
      },
    );
  }

  //Temp File Action Modal
  _showTempActionModal(String tempFile) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(StringConst.chooseActionText.tr,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16)),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: Text(
                'View ${!tempFile.contains('.mp4') ? 'Image' : 'Video'}',
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await openUploadPreview(
                    context: context,
                    file: File(tempFile),
                    isPreview: true,
                    isVideo: tempFile.contains('.mp4') ? true : false);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(
                StringConst.deleteText,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  tempFilesSet.remove(tempFile);
                  _getTempImages();
                });
              },
            ),
          ]),
    );
  }

  _getTempImageView(String path) => !path.contains('.mp4')
      ? getDecorationImage(FileImage(File(path)), false, path)
      : _getVideoImage(path);

  getDecorationImage(ImageProvider imageProvider, bool isVideo, String path) {
    return Container(
      key: ValueKey(path),
      height: 102,
      width: 102,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.greyBg.withOpacity(0.1),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: imageProvider,
          )),
      child: isVideo
          ? const Center(
              child: Icon(
                Iconsax.video5,
                size: 20,
                color: AppColors.primaryColor,
              ),
            )
          : Container(),
    );
  }

  _getVideoImage(String path) {
    return FutureBuilder<Uint8List?>(
      future: getVideoThumbnail(path),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.data == null) {
          return getDecorationImage(
              const AssetImage("assets/images/image_not_found.png"),
              true,
              "path");
        }
        return getDecorationImage(MemoryImage(snapshot.data!), true, path);
      },
    );
  }

  //Video Thumbnail
  Future<Uint8List?> getVideoThumbnail(String path) async {
    VideoPlayerController videoPlayerController =
        VideoPlayerController.file(File(path));
    return await video_thumbnail.VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: video_thumbnail.ImageFormat.JPEG,
      maxWidth: 128,
      timeMs: videoPlayerController.value.duration.inSeconds > 3 ? 3 : 1,
      quality: 25,
    );
  }

  Widget get _getImageUploadContainer => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: ReorderableListView(
                proxyDecorator: proxyDecorator,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex = newIndex - 1;
                    }
                    final item = imageWidgetList.removeAt(oldIndex);
                    imageWidgetList.insert(newIndex, item);
                  });
                },
                scrollDirection: Axis.horizontal,
                children: [...imageWidgetList, _getImageUploadItem()]),
          ),
          Text(
            StringConst.maxFivePhotoText.tr,
            style: const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
          ),
        ],
      );

  //Image Upload Item
  _getImageUploadItem() {
    int count = tempFilesSet.length;
    return count < 5
        ? GestureDetector(
            key: const ValueKey('upload'),
            onTap: () async {
              final File? file = await UploadMedia.uploadMediaData(context,
                  isOnlyPhoto: false);
              if (file != null) {
                setState(() {
                  tempFilesSet.add(file.path);
                  _getTempImages();
                });
              }
            },
            child: Container(
              width: 102,
              height: 102,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.greyBg.withOpacity(0.1),
                border: const GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    Color(0xFFFFB6A0),
                    Color(0xFFA5E3FD),
                    Color(0xFF778AFF),
                    Color(0xFFFFCBF2),
                  ]),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.black.withOpacity(0.1),
                    ),
                    child: Image.asset('assets/icons/add_orange.png'),
                  ),
                  Text(
                    StringConst.addPhotoText.tr,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.primaryGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink(
            key: ValueKey('sizedBox'),
          );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 0,
          color: Colors.transparent,
          child: child,
        );
      },
      child: child,
    );
  }

  get _getLanguage => Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            _getTitle(StringConst.languageText.tr),
            LanguageDropdownItem(
              prefix: ConfigsKeyHelper.articleCreateLanguageKey,
              title: 'Language'.tr,
              isBorderGradient: true,
              onValueChanged: (value) {
                final langValue = languageList.singleWhere(
                    (element) => element.language == value,
                    orElse: () => defaultLanguage);
                setState(() {
                  selectedValue = langValue;
                });
              },
              initialValue: "${selectedValue.language}",
              topCountries: const [],
              icon: Iconsax.arrow_circle_down,
            )
          ]),
        ],
      );

  _getTitle(String name) {
    return Text(
      name,
      style: const TextStyle(color: AppColors.white, fontSize: 16),
    );
  }
}
