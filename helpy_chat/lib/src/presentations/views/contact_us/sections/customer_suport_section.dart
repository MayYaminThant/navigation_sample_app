part of '../../views.dart';

class CustomerSuportSection extends StatefulWidget {
  const CustomerSuportSection({super.key});

  @override
  State<CustomerSuportSection> createState() => _CustomerSuportSectionState();
}

class _CustomerSuportSectionState extends State<CustomerSuportSection> {
  int countryCallCode = 65;
  final TextEditingController emailController = TextEditingController();
  Map? employerData;
  bool isChecked = false;
  bool isLoading = false;
  bool isPopUpMessage = false;
  String issue = 'Select Your Problem';
  final TextEditingController loginNameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool _isChecked = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String route = '';
  bool isClicked = false;
  Set<String> tempFilesSet = {};

  @override
  void initState() {
    _getEmployerData();
    super.initState();
  }

  Future<void> _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.candidateTableName);
    });
    await _initializeData();
  }

  Future<void> _initializeData() async {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }
    await _initializeUserData();
  }

  //Initialize User Data
  Future<void> _initializeUserData() async {
    if (employerData != null) {
      User user = UserModel.fromJson(employerData!);
      setState(() {
        nameController.text =
            StringUtils.getFullName(user.firstName ?? '', user.lastName ?? '');
        emailController.text = user.email ?? '';
        phoneNumberController.text =
            user.phoneNumber != null ? user.phoneNumber.toString() : '';
        countryCallCode =
            user.phoneNumber != null ? user.countryCallingCode! : 65;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
        availableBack: false,
        onWillPop: () async {
          Get.offAllNamed(contactUsPageRoute);
          return false;
        },
        scaffold: Scaffold(
          key: _scaffoldKey,
          appBar: _getAppBar,
          drawerScrimColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          body: _getContactUsScaffold,
        ));
  }

  Widget get _getContactUsScaffold {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: _getContactUsContainer,
          ),
          isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ))
              : Container()
        ],
      );
    }, listener: (_, state) {
      if (state is CandidateContactUsSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          _showSuccessInfo(context);
          _clearData();
        }
      }

      if (state is CandidateContactUsFail) {
        Loading.cancelLoading();
        setState(() {
          isLoading = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.offAllNamed(contactUsPageRoute),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.customerSuportText.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
      );

  Widget get _getContactUsContainer {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
          vertical: Sizes.padding20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Please leave your message and we will get back to you shortly.'
                  .tr,
              style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.primaryGrey,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 15,
            ),
            _getTextField(nameController, "Enter Your Name".tr, 1, true),
            _getTextField(
                emailController, "Enter Your Email Address".tr, 1, true),
            _getPhoneNumber,
            const SizedBox(
              height: 15,
            ),
            _getProblemDropDown,
            _getTextField(
                messageController,
                "Enter Your Message\n*Please be specific for your problem",
                10,
                true),
            const SizedBox(
              height: 10,
            ),
            _getImageUploadContainer,
            const SizedBox(
              height: 10,
            ),
            _getCheckBox,
            CustomPrimaryButton(
                text: 'Send Message',
                widthButton: 800,
                onPressed: () => _checkValidations()),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTextField(TextEditingController controller, String title,
      int? maxLine, bool isRequired,
      {TextInputType? inputType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: CustomTextField(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: controller.text.isEmpty && isRequired && isClicked
                    ? Border.all(color: AppColors.red)
                    : null,
                color: AppColors.cardColor.withOpacity(0.1)),
            maxLine: maxLine ?? 1,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
            controller: controller,
            textInputType: inputType,
            inputFormatters: [
              if (inputType == TextInputType.number)
                FilteringTextInputFormatter.digitsOnly
            ],
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            hasPrefixIcon: false,
            hasTitle: true,
            isRequired: true,
            titleStyle: const TextStyle(
              color: AppColors.white,
              fontSize: Sizes.textSize14,
            ),
            hasTitleIcon: false,
            enabledBorder: Borders.noBorder,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: const BorderSide(color: AppColors.white),
            ),
            hintTextStyle:
                const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
            textStyle: const TextStyle(color: AppColors.primaryGrey),
            hintText: title,
          ),
        ),
      ],
    );
  }

  Widget get _getProblemDropDown {
    return DropdownItem(
      datas: const [],
      initialValue: issue,
      title: 'Problem',
      onValueChanged: (String value) {
        setState(() {
          issue = value;
        });
      },
      suffixIcon: Iconsax.arrow_down5,
      prefix: ConfigsKeyHelper.customerSupportIssueKey,
      isRequired: isClicked,
    );
    //DropdownButton(items: {}, onChanged: onChanged)
  }

  Widget get _getCheckBox {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            height: 21,
            width: 21,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              border: _isChecked
                  ? null
                  : Border.all(color: Colors.white, width: 2.0),
            ),
            child: Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.transparent,
              ),
              child: Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
                activeColor: Colors.white,
                checkColor: Colors.blue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            'Can directly contact me via phone'.tr,
            style: const TextStyle(fontSize: 12, color: AppColors.greyShade2),
          ),
        ],
      ),
    );
  }

  //Check validation for contact us form
  void _checkValidations() {
    setState(() {
      isClicked = true;
    });
    List<String> requiredControllers = [
      nameController.text.isNotEmpty ? nameController.text.toString() : '',
      emailController.text.isNotEmpty ? emailController.text.toString() : '',
      issue != 'Select Your Problem' ? issue : '',
      messageController.text.isNotEmpty
          ? messageController.text.toString()
          : '',
    ];

    List<String> requiredMessages = const [
      StringConst.yourNameText,
      StringConst.yourEmailText,
      StringConst.yourProblemText,
      StringConst.yourMessageText,
    ];

    if (requiredControllers.indexWhere((f) => f == '' || f == '0') != -1) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: SizedBox(
                  width: 300,
                  child: ValueErrorPopup(
                      values: requiredControllers,
                      messages: requiredMessages,
                      nextRoute: '',
                      currentRoute: '',
                      isExit: true),
                ),
              ));
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      showErrorSnackBar(StringConst.invalidEmailText);
    } else if (_isChecked && phoneNumberController.text.isEmpty) {
      showErrorSnackBar(StringConst.phoneNumberRequiredText);
    } else if (phoneNumberController.text.isNotEmpty &&
        (phoneNumberController.text.length < 7 ||
            phoneNumberController.text.length > 20)) {
      showErrorSnackBar(StringConst.invalidPhoneNumber);
    } else {
      showCaptchaModal();
    }
  }

  Future<void> _createContactMessage() async {
    final CandidateBloc candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateContactUsRequestParams params = CandidateContactUsRequestParams(
        token: employerData != null ? employerData!['token'] : null,
        email: emailController.text,
        issue: issue != 'Select Your Problem' ? issue : null,
        countryCallingCode:
            phoneNumberController.text.isNotEmpty ? countryCallCode : null,
        message: messageController.text,
        name: nameController.text,
        phone: phoneNumberController.text.isNotEmpty
            ? phoneNumberController.text
            : null,
        images: tempFilesSet.isNotEmpty
            ? List<File>.generate(tempFilesSet.length,
                (int index) => File(tempFilesSet.toList()[index]))
            : null,
        canContactViaPhone: _isChecked ? 1 : 0);

    candidateBloc.add(CandidateContactUsRequested(params: params));
    //}
  }

  void _showSuccessInfo(BuildContext ctx) {
    bool isDialogOpen = false;
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (_) {
          isDialogOpen = true;
          void closeDialog() {
            if (ctx.mounted) {
              isDialogOpen ? Navigator.of(ctx).pop() : null;
              isDialogOpen = false;
            }
          }

          Timer(const Duration(seconds: 3), () => closeDialog());
          return WillPopScope(
            onWillPop: () async {
              isDialogOpen = false;
              return true;
            },
            child: AlertDialog(
              backgroundColor: AppColors.greyBg,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Container(
                  color: AppColors.greyBg,
                  height: 207,
                  width: 326,
                  child: const MessageSentPopUp(
                    title: 'Your Message has been\nsent.',
                    message: 'We will contact you very soon.',
                  )),
            ),
          );
        });
  }

  void _clearData() {
    setState(() {
      isClicked = false;
      messageController.clear();
      tempFilesSet.clear();
      issue = 'Select Your Problem';
      DBUtils.clearData(DBUtils.tempSupport);
    });
    if (employerData != null) {
      _initializeUserData();
    } else {
      setState(() {
        nameController.clear();
        emailController.clear();
        phoneNumberController.clear();
        countryCallCode = 65;
      });
    }
  }

  Widget get _getPhoneNumber => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: 160,
              child: PhoneNumberDropdownItem(
                initialValue: countryCallCode.toString(),
                title: StringConst.countryText.tr,
                onValueChanged: (Country country) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      countryCallCode = int.parse(country.dialCode ?? '65');
                    });
                  });
                },
                isCallCode: true,
                prefix: ConfigsKeyHelper.customerSupportPhoneKey,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: _getTextField(phoneNumberController,
                  StringConst.phoneNumberOnlyText, 1, _isChecked,
                  inputType: TextInputType.number)),
        ],
      );

  Widget get _getImageUploadContainer {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: ReorderableListView(
              proxyDecorator: proxyDecorator,
              onReorder: (oldIndex, newIndex) {
                final tempList = tempFilesSet.toList();
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex = newIndex - 1;
                  }
                  final item = tempList.removeAt(oldIndex);
                  tempList.insert(newIndex, item);
                  tempFilesSet = tempList.toSet();
                  _getTempImages;
                });
              },
              scrollDirection: Axis.horizontal,
              children: [..._getTempImages, _getImageUploadItem()]),
        ),
        Text(
          StringConst.pictureUploadDescriptionText.tr,
          style: const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
        ),
      ],
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

  Widget _getImageUploadItem() {
    int count = tempFilesSet.length;
    return count < 5
        ? GestureDetector(
            key: const ValueKey('upload'),
            onTap: () async {
              FocusScope.of(context).unfocus();
              final File? file = await UploadMedia.uploadMediaData(context,
                  isOnlyPhoto: true, isContactUs: true);
              if (file != null) {
                setState(() {
                  tempFilesSet.add(file.path);
                  _getTempImages;
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
                    StringConst.updatePhotoText.tr,
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

  static Future<File?> openUploadPreview(
      {required BuildContext context,
      required File file,
      required bool isPreview,
      required bool isVideo,
      required bool isContactUs}) async {
    return showDialog<File?>(
      context: context,
      builder: (BuildContext context) {
        return UploadPreview(
          originalFile: file,
          preview: isPreview,
          isVideo: isVideo,
          isContactUs: isContactUs,
        );
      },
    );
  }

  //Temp File Action Modal
  void _showTempActionModal(String tempFile) {
    showCupertinoModalPopup(
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
                    isVideo: tempFile.contains('.mp4') ? true : false,
                    isContactUs: true);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(
                StringConst.deleteText,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
              onPressed: () {
                setState(() {
                  tempFilesSet.remove(tempFile);
                  _getTempImages;
                  Navigator.pop(context);
                });
              },
            ),
          ]),
    );
  }

  Widget _getTempImageView(String path) => !path.contains('.mp4')
      ? getDecorationImage(FileImage(File(path)), false, path)
      : _getVideoImage(path);

  Set<Widget> get _getTempImages {
    Set<Widget> imageWidgetList = {};
    for (var element in tempFilesSet) {
      imageWidgetList.add(Row(
        key: UniqueKey(),
        children: [
          GestureDetector(
            onTap: () => _showTempActionModal(element),
            child: _getTempImageView(element),
          ),
        ],
      ));
    }
    return imageWidgetList;
  }

  Widget getDecorationImage(
      ImageProvider imageProvider, bool isVideo, String path) {
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
      builder: (_, snapshot) {
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

  void showCaptchaModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PhluidSliderCaptch(
          onValueChanged: (bool value) {
            if (value) {
              Navigator.of(context).pop();
              Loading.showLoading(message: StringConst.loadingText);
              _createContactMessage();
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    nameController.dispose();
    messageController.dispose();
    loginNameController.dispose();
    emailController.dispose();
    Loading.cancelLoading();
    super.dispose();
  }
}
