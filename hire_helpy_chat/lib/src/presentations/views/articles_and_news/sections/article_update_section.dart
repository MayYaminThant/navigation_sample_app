part of '../../views.dart';

class ArticleUpdateSection extends StatefulWidget {
  const ArticleUpdateSection({super.key});

  @override
  State<ArticleUpdateSection> createState() => _ArticleUpdateSectionState();
}

class _ArticleUpdateSectionState extends State<ArticleUpdateSection> {
  final TextEditingController _articleTitleController = TextEditingController();
  final TextEditingController _articleDescriptionController =
      TextEditingController();
  Map? employerData;
  Set<String> tempFiles = {};
  String route = '';
  List<Widget> imageWidgetList = [];
  String description = '';
  List<ConfigLanguage> languageList = [];
  ConfigLanguage selectedValue =
      const ConfigLanguage(language: "English", languageName: "English");
  ArticleDetail? articleDetail;
  List<MediaFile> mediaFileList = [];
  String basePhotoUrl = '';
  bool isLoading = true;

  String originalTitle = '';
  String originalDescription = '';

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getPhotoUrl();
    await _getLanguageData();
    await _getCandidateData();
    await _initializeTempData();
    await _initializeData();
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    basePhotoUrl = data;
  }

  Future<void> _initializeData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    String? encodedArticleDetail = box.get('article_update');
    final String lang = box.get(DBUtils.language) ?? 'English';

    if (encodedArticleDetail != null) {
      final tempArticleDetail =
          ArticleDetailModel.fromJson(json.decode(encodedArticleDetail));
      final tempSelectedValue = languageList.singleWhere(
          (element) =>
              element.language ==
              (tempArticleDetail.articleLanguage != null
                  ? tempArticleDetail.articleLanguage!
                  : lang),
          orElse: () => const ConfigLanguage(
              language: "English", languageName: "English"));
      if (tempFiles.isEmpty) {
        await _initializeUploadImage(articleDetail: tempArticleDetail);
      }

      setState(() {
        articleDetail = tempArticleDetail;
        selectedValue = tempSelectedValue;
        isLoading = false;
      });
      _articleTitleController.text = articleDetail!.title ?? '';
      _articleDescriptionController.text = articleDetail!.content ?? '';
      originalTitle = _articleTitleController.text;
      originalDescription = _articleDescriptionController.text;
    } else {
      Get.back();
    }
  }

  bool get _filledOrChangedRequiredFields {
    return (_articleTitleController.text != originalTitle ||
            _articleDescriptionController.text != originalDescription) &&
        tempFiles.isNotEmpty;
  }

  Future<void> _initializeUploadImage(
      {required ArticleDetailModel articleDetail}) async {
    if (articleDetail.media != null) {
      mediaFileList = articleDetail.media ?? [];
      final localFiles = await cacheS3Files(
          filePaths: mediaFileList
              .map((media) => media.mediaFilePath)
              .whereType<String>()
              .toList());
      if (localFiles.isNotEmpty) {
        tempFiles = localFiles.toSet();
        setState(() {
          _getTempImages();
        });
      }
    }
  }

  //Language Data List with top Countries
  Future<void> _getLanguageData() async {
    List<ConfigLanguage> dataList =
        await LanguageUtils.getArticleCreateConfigLanguages();
    setState(() {
      languageList.addAll(dataList);
    });
  }

  Future<void> _initializeTempData() async {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
      String fileString = Get.parameters['file'] ?? '';
      getFiles(fileString); // populate tempFiles
      _articleTitleController.text = Get.parameters['title'] ?? '';
      _articleDescriptionController.text = Get.parameters['description'] ?? '';
    }

    if (tempFiles.isNotEmpty) {
      setState(() {
        _getTempImages();
      });
    }
  }

  void getFiles(String fileString) {
    List<String> dataList = [];
    final String data = Get.parameters['tempFiles'] ?? "";
    if (data != "[]") {
      Iterable iterable = json.decode(data);
      for (var element in iterable) {
        dataList.add(element);
      }
      if (dataList.isNotEmpty) {
        tempFiles = dataList.toSet();
      }
    }
    setState(() {
      tempFiles.add(fileString);
    });
  }

  void _getTempImages() {
    imageWidgetList.clear();
    for (var element in tempFiles) {
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

  void showAlertLimitCharModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogSimple(
          message:
              'You have hit the $kCommentCharacterLimitation character limit for posting article description.',
          positiveText: 'OK',
          onButtonClick: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _requestUpdateArticle() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticleUpdateRequestParams params = ArticleUpdateRequestParams(
      token: employerData!['token'],
      title: _articleTitleController.text,
      content: _articleDescriptionController.text,
      articleId: articleDetail!.articleId,
      images: tempFiles.isNotEmpty
          ? List<File>.generate(
              tempFiles.length, (int index) => File(tempFiles.toList()[index]))
          : null,
      //media: _getMediaFiles(),
      language: selectedValue.language,
    );
    articleBloc.add(ArticleUpdateRequested(params: params));
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.employerTableName);

    if (data != null) {
      employerData = data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
        onWillPop: _backButtonPressed, scaffold: _getArticleCreateScaffold);
  }

  Scaffold get _getArticleCreateScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: _getArticleCreateContainer,
    );
  }

  _backButtonPressed() {
    _requestInitialize();
    Get.offNamed(articlesListPageRoute, parameters: {'preview': 'false'});
    DBUtils.saveListData([], 'temp_article_files');
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: _backButtonPressed,
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: const Text(
          'Edit Article',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
        actions: const [],
      );

  Widget get _getArticleCreateContainer {
    return BlocConsumer<ArticleBloc, ArticleState>(
      builder: (_, state) {
        return isLoading ? LoadingScaffold.getLoading() : _getListArticleCreate;
      },
      listener: (_, state) {
        if (state is ArticleUpdateLoading) {
          Loading.showLoading(message: StringConst.loadingText);
        }

        if (state is ArticleUpdateSuccess) {
          Loading.cancelLoading();
          showSuccessSnackBar(state.articleData.data!['message']);
          setState(() {
            tempFiles.clear();
            DBUtils.saveListData([], 'temp_article_files');
          });
          Get.offAndToNamed(articlesListPageRoute,
              parameters: {'preview': 'false'});
        }

        if (state is ArticleUpdateFail) {
          Loading.cancelLoading();
          showErrorSnackBar(state.message);
        }
      },
    );
  }

  Widget get _getListArticleCreate {
    return SingleChildScrollView(
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
            controller: _articleTitleController,
            maxLength: 50,
            style: const TextStyle(color: AppColors.white, fontSize: 14),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText:
                  'Article title \n *Please write a short title to make it more engaging.',
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
            expands: true,
            maxLength: 8000,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            controller: _articleDescriptionController,
            onChanged: (value) {
              if (value.length >= 8000) {
                showAlertLimitCharModal(context);
                description = value;
              }
            },
            style: const TextStyle(color: AppColors.white, fontSize: 14),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText:
                  'Article Description \n *Please be as detailed as possible',
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

  Widget get _getButtonPostArticle {
    return Row(
      children: [
        Expanded(
          child: CustomOutlineButton(
            text: 'Cancel',
            onPressed: () {
              _backButtonPressed();
            },
            textColor: AppColors.primaryColor,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: CustomPrimaryButton(
            text: 'Update Article',
            onPressed:
                !_filledOrChangedRequiredFields ? null : () => _verifyFields(),
            fontSize: 15,
            customColor: _filledOrChangedRequiredFields
                ? AppColors.primaryColor
                : Colors.grey,
          ),
        )
      ],
    );
  }

  void _verifyFields() {
    if (_articleTitleController.text.isEmpty) {
      showErrorSnackBar('Please enter the Article Title.');
    } else if (_articleDescriptionController.text.isEmpty) {
      showErrorSnackBar('Please enter the Article Description.');
    } else if (_articleDescriptionController.text.isNotEmpty &&
        _articleDescriptionController.text.length >
            kCommentCharacterLimitation) {
      showAlertLimitCharModal(context);
    } else if (tempFiles.isEmpty && mediaFileList.isEmpty) {
      showErrorSnackBar('Please Add your photos.');
    } else {
      _requestUpdateArticle();
    }
  }

  //Temp File Action Modal
  void _showTempActionModal(String tempFile) => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
            title: Text('Choose Action',
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
                onPressed: () {
                  Navigator.pop(context);
                  Get.toNamed(
                      !tempFile.contains('.mp4')
                          ? imageViewPageRoute
                          : videoViewPageRoute,
                      parameters: {
                        'path': tempFile,
                        'preview': 'true',
                        'type': 'assets'
                      });
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
                    int index = imageWidgetList.indexWhere(
                        (item) => item.key.toString().contains(tempFile));
                    imageWidgetList.removeAt(index);
                    tempFiles.remove(tempFile);
                  });
                },
              ),
            ]),
      );

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

  Widget _getVideoImage(String path) {
    return FutureBuilder<Uint8List?>(
      future: getVideoThumbnail(path),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return getDecorationImage(MemoryImage(snapshot.data!), true, path);
        }
        return Container();
      },
    );
  }

  //Video Thumbnail
  Future<Uint8List?> getVideoThumbnail(String path) async {
    return await videoThumbnail.VideoThumbnail.thumbnailData(
      video: path,
      // video path
      imageFormat: videoThumbnail.ImageFormat.JPEG,
      maxWidth: 128,
      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
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
            StringConst.maxFivePhotoText,
            style: const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
          ),
        ],
      );

  //Image Upload Button
  Widget _getImageUploadItem() {
    int count = tempFiles.length;
    return count < 5
        ? GestureDetector(
            key: const ValueKey('upload'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => UpdatePhotoModal(
                        route: articleEditPageRoute,
                        isOnlyPhoto: false,
                        tempFiles: tempFiles,
                        title: _articleTitleController.text,
                        description: _articleDescriptionController.text,
                      ));
            },
            child: Container(
              width: 102,
              height: 102,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyBg.withOpacity(0.1)),
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
                  const Text(
                    StringConst.addPhotoOrVideoText,
                    style: TextStyle(
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

  void _requestInitialize() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(InitializeArticleEvent());
  }

  Widget get _getLanguage => Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            _getTitle(StringConst.languageText.tr),
            LanguageDropdownItem(
              prefix: ConfigsKeyHelper.articleCreateLanguageKey,
              title: 'Language'.tr,
              hasColouredBorder: true,
              onValueChanged: (value) {
                final langValue = languageList.singleWhere(
                    (element) => element.language == value,
                    orElse: () => const ConfigLanguage(
                        language: "English", languageName: "English"));
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

  Widget _getTitle(String name) {
    return Text(
      name,
      style: const TextStyle(color: AppColors.white, fontSize: 16),
    );
  }

  //Action Modal
  void _showMediaActionModal(MediaFile mediaFile) => showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
            title: Text('Choose Action',
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: Text(
                  'View ${!mediaFile.mediaFilePath!.contains('.mp4') ? 'Image' : 'Video'}',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Get.toNamed(
                      !mediaFile.mediaFilePath!.contains('.mp4')
                          ? imageViewPageRoute
                          : videoViewPageRoute,
                      parameters: {
                        'path':
                            '$basePhotoUrl/${mediaFile.mediaFilePath ?? ''}',
                        'preview': 'true',
                        'type': 'network'
                      });
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
                    int index = imageWidgetList.indexWhere((item) =>
                        item.key.toString().contains(mediaFile.mediaFilePath!));
                    imageWidgetList.removeAt(index);
                    mediaFileList.remove(mediaFile);
                  });
                },
              ),
            ]),
      );

  String? _getMediaFiles() {
    List<String> dataList = [];
    for (int i = 0; i < imageWidgetList.length; i++) {
      String data = imageWidgetList[i].key.toString();
      String medidFileModel = '<MediaFileModel(';
      if (data.contains(medidFileModel)) {
        List<String> stringList = data.split(',');
        dataList.add(stringList[0].replaceAll(medidFileModel, '').toString());
      }
    }
    return dataList.isNotEmpty
        ? dataList
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(' ', '')
        : null;
  }
}
