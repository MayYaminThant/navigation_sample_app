part of '../../views.dart';

class ArticleCreateSection extends StatefulWidget {
  const ArticleCreateSection({super.key});

  @override
  State<ArticleCreateSection> createState() => _ArticleCreateSectionState();
}

class _ArticleCreateSectionState extends State<ArticleCreateSection> {
  final TextEditingController _articleTitleController = TextEditingController();
  final TextEditingController _articleDescriptionController =
      TextEditingController();
  final ConfigLanguage defaultLanguage =
      const ConfigLanguage(language: "English", languageName: "English");
  Map? employerData;
  Set<String> tempFiles = {};
  String route = '';
  List<Widget> imageWidgetList = [];
  String description = '';
  List<ConfigLanguage> languageList = [];
  ArticleDetail? articleDetail;
  bool isUploading = false;
  late ConfigLanguage selectedValue;

  @override
  void initState() {
    selectedValue = defaultLanguage;
    _initializeData();
    _getEmployerData();
    _getLanguageData();
    // _articleDescriptionController.addListener(() {
    //   if (_articleDescriptionController.text.length >=
    //       kCommentCharacterLimitation) {
    //     showAlertLimitCharModal(context);
    //   }
    // });
    super.initState();
  }

  void changeUploading(bool value) {
    setState(() {
      if (value) {
        Loading.showLoading(message: StringConst.loadingText);
      } else {
        _articleTitleController.clear();
        _articleDescriptionController.clear();
        tempFiles.clear();
        imageWidgetList.clear();
        _closeKeyboardIfOpen();
        Loading.cancelLoading();
      }
      isUploading = value;
    });
  }

  _initializeData() async {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
      final String fileString = Get.parameters['file'] ?? "";
      getFiles(fileString);
      _articleTitleController.text = Get.parameters['title'] ?? '';
      _articleDescriptionController.text = Get.parameters['description'] ?? '';
    }

    if (tempFiles.isNotEmpty) {
      setState(() {
        _getTempImages();
      });
    }
  }

  //Language Data List with top Countries
  void _getLanguageData() async {
    List<ConfigLanguage> dataList =
        await LanguageUtils.getArticleCreateConfigLanguages();

    setState(() {
      languageList.addAll(dataList);
      selectedValue = languageList.singleWhere(
        (element) =>
            element.language == (Get.parameters['language'] ?? "English"),
        orElse: () => defaultLanguage,
      );
    });
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
            _titleLimitExceededDialogShown = false;
          },
        );
      },
    );
  }

  void _requestArticleList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesListRequestParams params = ArticlesListRequestParams(
        token: employerData != null ? employerData!['token'] : null,
        language: selectedValue.language ?? "English",
        sortBy: "latest",
        page: articleBloc.loadMorePage);
    articleBloc.add(ArticlesListRequested(params: params));
  }

  _requestcreateArticle() {
    setState(() {
      isUploading = true;
    });
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesCreateRequestParams params = ArticlesCreateRequestParams(
        token: employerData!['token'],
        title: _articleTitleController.text,
        content: _articleDescriptionController.text,
        images: tempFiles.isNotEmpty
            ? List<File>.generate(tempFiles.length,
                (int index) => File(tempFiles.toList()[index]))
            : null,
        language: selectedValue.language);
    articleBloc.add(ArticlesCreateRequested(params: params));
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.employerTableName);
    final String lang = box.get(DBUtils.language) ?? 'English';
    selectedValue = languageList.singleWhere(
        (element) => element.language == lang,
        orElse: () => defaultLanguage);
    if (data != null) {
      employerData = data;
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
      onWillPop: () async {
        if (isUploading) {
          return false;
        }
        _requestArticleList();
        Get.toNamed(articlesListPageRoute);
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

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: isUploading
              ? null
              : () {
                  _requestArticleList();
                  Get.toNamed(articlesListPageRoute);
                },
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          'Create Article'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
        actions: const [],
      );

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

  bool _titleLimitExceededDialogShown = false;

  Widget get _getArticleAddTitleForm {
    return Stack(
      children: [
        Container(
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
            maxLength: 50,
            controller: _articleTitleController,
            style: const TextStyle(color: AppColors.white, fontSize: 14),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              if (value.length >= 50 && !_titleLimitExceededDialogShown) {
                _titleLimitExceededDialogShown = true;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogSimple(
                      message:
                          'You have hit the 50 character limit for posting article description.',
                      positiveText: 'OK',
                      onButtonClick: () {
                        Navigator.pop(context);
                        _titleLimitExceededDialogShown = false;
                      },
                    );
                  },
                );
              }
            },
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
          padding: const EdgeInsets.only(bottom: 13),
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
              if (value.length >= 8000 && !_titleLimitExceededDialogShown) {
                _titleLimitExceededDialogShown = true;
                showAlertLimitCharModal(context);
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
    return BlocConsumer<ArticleBloc, ArticleState>(
      builder: (_, state) {
        return CustomPrimaryButton(
          text: 'Post Article',
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
          showSuccessSnackBar(state.articleData.data!['message']);
          BlocProvider.of<ArticleBloc>(context).resetState();
          Future.delayed(const Duration(seconds: 2), () {
            Get.offAndToNamed(articlesListPageRoute);
          });
        }

        if (state is ArticlesCreateFail) {
          changeUploading(false);
          showErrorSnackBar(state.message);
        }
      },
    );
  }

  bool get _filledRequiredFields {
    return _articleTitleController.text.isNotEmpty &&
        _articleDescriptionController.text.isNotEmpty &&
        tempFiles.isNotEmpty;
  }

  _verifyFields() {
    if (_articleTitleController.text.isEmpty) {
      showErrorSnackBar('Please enter the Article Title.');
    } else if (_articleDescriptionController.text.isEmpty) {
      showErrorSnackBar('Please enter the Article Description.');
    } else if (_articleDescriptionController.text.length >
        kCommentCharacterLimitation) {
      showAlertLimitCharModal(context);
    } else if (tempFiles.isEmpty) {
      showErrorSnackBar('Please Add your photos.');
    } else if (isUploading) {
    } else {
      _requestcreateArticle();
    }
  }

  //Temp File Action Modal
  _showTempActionModal(String tempFile) => showCupertinoModalPopup<void>(
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
                        'type': 'assets',
                        "tempFiles": json.encode(tempFiles.toList()),
                        'title': _articleTitleController.text,
                        'description': _articleDescriptionController.text
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
                    tempFiles.remove(tempFile);
                    _getTempImages();
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

  _getVideoImage(String path) {
    return FutureBuilder<Uint8List?>(
      future: getVideoThumbnail(path),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return getDecorationImage(MemoryImage(snapshot.data!), true, path);
        }
        return LoadingScaffold.getLoading();
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
            StringConst.maxFivePhotoText.tr,
            style: const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
          ),
        ],
      );

  //Image Upload Item
  _getImageUploadItem() {
    int count = tempFiles.length;
    return count < 5
        ? GestureDetector(
            key: const ValueKey('upload'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => UpdatePhotoModal(
                        route: articleCreate,
                        isOnlyPhoto: false,
                        tempFiles: tempFiles,
                        title: _articleTitleController.text,
                        description: _articleDescriptionController.text,
                        language: selectedValue.language,
                      ));
            },
            child: Container(
              width: 102,
              height: 102,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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

  get _getLanguage => Table(
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
