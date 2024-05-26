part of '../../views.dart';

class CustomerSuportSection extends StatefulWidget {
  const CustomerSuportSection({super.key});

  @override
  State<CustomerSuportSection> createState() => _CustomerSuportSectionState();
}

class _CustomerSuportSectionState extends State<CustomerSuportSection> {
  final int maxImageCount = 5;
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
  Set<Widget> imageWidgetList = {};
  Set<String> tempFiles = {};
  String route = '';
  Map? tempSupportData;
  bool isClicked = false;

  @override
  void initState() {
    _getEmployerData();
    super.initState();
  }

  Future<void> _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
    await _initializeData();
  }

  Future<void> _initializeData() async {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
      String fileString = Get.parameters['file'] ?? '';
      getFiles(fileString);
    }

    if (tempFiles.isNotEmpty) {
      setState(() {
        _getTempImages();
      });
    }

    tempSupportData = await _getTempSupportData();
    if (tempSupportData != null) {
      await _initializeTempData();
    } else {
      await _initializeUserData();
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

  //Get Temp Support Data
  Future<Map<dynamic, dynamic>?> _getTempSupportData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    return box.get(DBUtils.tempSupport);
  }

  //InitializeTempData
  Future<void> _initializeTempData() async {
    setState(() {
      nameController.text = tempSupportData!['name'] ?? '';
      emailController.text = tempSupportData!['email'] ?? '';
      phoneNumberController.text = tempSupportData!['phone_number'] ?? '';
      countryCallCode = tempSupportData!['country_call_code'] ?? 65;
      issue = tempSupportData!['issue'] ?? '';
      messageController.text = tempSupportData!['message'] ?? '';
      _isChecked = tempSupportData!['is_checked'] ?? false;
    });
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
        onWillPop: () {
          Get.offNamed(contactUsPageRoute);
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
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: _getContactUsContainer,
          ),
          // isLoading
          //     ? Container(
          //         color: Colors.black.withOpacity(0.5),
          //         child: const Center(
          //           child: CircularProgressIndicator(color: Colors.white),
          //         ))
          //     : Container()
        ],
      );
    }, listener: (_, state) {
      if (state is EmployerContactUsSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          _showSuccessInfo();
          _clearData();
        }
      }

      if (state is EmployerContactUsFail) {
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
          onTap: () {
            Get.offNamed(contactUsPageRoute);
          },
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.customerSuportText,
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
            const SizedBox(height: 15),
            _getTextField(nameController, "Enter Your Name".tr, 1, true),
            _getTextField(
                emailController, "Enter Your Email Address".tr, 1, true),
            _getPhoneNumber,
            const SizedBox(height: 15),
            _getProblemDropDown,
            _getTextField(
                messageController,
                "Enter Your Message\n*Please be specific for your problem",
                10,
                true),
            const SizedBox(height: 10),
            _getImageUploadContainer(),
            const SizedBox(height: 10),
            _getCheckBox,
            CustomPrimaryButton(
                text: 'Send Message',
                widthButton: 800,
                onPressed: isLoading ? null : () => _checkValidations()),
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
          const Text(
            'Can directly contact me via phone',
            style: TextStyle(fontSize: 12, color: AppColors.greyShade2),
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
                content: Builder(
                  builder: (context) {
                    return SizedBox(
                      width: 300,
                      child: ValueErrorPopup(
                          values: requiredControllers,
                          messages: requiredMessages,
                          nextRoute: '',
                          currentRoute: '',
                          isExit: true),
                    );
                  },
                ),
              ));
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      showErrorSnackBar(StringConst.invalidEmailText);
    } else if (_isChecked && phoneNumberController.text.isEmpty) {
      showErrorSnackBar(StringConst.phoneNumberRequiredText);
    } else if (phoneNumberController.text.isNotEmpty &&
        (phoneNumberController.text.length < 7 ||
            phoneNumberController.text.length > 20)) {
      showErrorSnackBar(StringConst.invalidPhoneNumber);
    } else {
      if (isLoading) {
        return;
      }
      showCaptchaModal();
    }
  }

  Future<void> _createContactMessage() async {
    // bool isValid = await FlutterNumberCaptcha.show(context,
    //     accentColor: AppColors.primaryColor,
    //     titleText: "I'm not a robot.",
    //     checkCaption: 'Verify');
    // if (isValid) {
    // ignore: use_build_context_synchronously
    final EmployerBloc employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerContactUsRequestParams params = EmployerContactUsRequestParams(
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
        images: tempFiles.isNotEmpty
            ? List<File>.generate(tempFiles.length,
                (int index) => File(tempFiles.toList()[index]))
            : null,
        canContactViaPhone: _isChecked ? 1 : 0);

    employerBloc.add(EmployerContactUsRequested(params: params));
    //}
  }

  void _showSuccessInfo() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
                backgroundColor: AppColors.greyBg,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Builder(
                  builder: (context) {
                    return Container(
                        color: AppColors.greyBg,
                        height: 207,
                        width: 326,
                        child: const MessageSentPopUp(
                          title: 'Your Message has been\nsent.',
                          message: 'We will contact you very soon.',
                        ));
                  },
                ),
              ));
    }).then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    });
  }

  void _clearData() {
    setState(() {
      messageController.clear();
      tempFiles = {};
      imageWidgetList = {};
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
              width: 155,
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

  Widget _getImageUploadContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: ReorderableListView(
              proxyDecorator: proxyDecorator,
              onReorder: (oldIndex, newIndex) {
                final tempList = imageWidgetList.toList();
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex = newIndex - 1;
                  }
                  final item = tempList.removeAt(oldIndex);
                  tempList.insert(newIndex, item);
                  imageWidgetList = tempList.toSet();
                });
              },
              scrollDirection: Axis.horizontal,
              children: [...imageWidgetList, _getImageUploadItem()]),
        ),
        Text(
          StringConst.pictureUploadDescriptionText,
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
    return tempFiles.length >= maxImageCount
        ? const SizedBox.shrink(key: ValueKey('sizedBox'))
        : GestureDetector(
            key: const ValueKey('upload'),
            onTap: () {
              _saveTempSupportData();
              showDialog(
                  context: context,
                  builder: (context) => UpdatePhotoModal(
                        route: customerSuportPageRoute,
                        isOnlyPhoto: true,
                        tempFiles: tempFiles,
                        title: 'title',
                        description: 'description',
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                    StringConst.addPhotoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primaryGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
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
                    int index = imageWidgetList.toList().indexWhere(
                        (item) => item.key.toString().contains(tempFile));
                    imageWidgetList.toList().removeAt(index);
                    tempFiles.remove(tempFile);
                  });
                  _getTempImages();
                },
              ),
            ]),
      );

  Widget _getTempImageView(String path) =>
      getDecorationImage(FileImage(File(path)), false, path);

  void _getTempImages() {
    imageWidgetList
      ..clear()
      ..addAll(
        List<Widget>.generate(
          tempFiles.length,
          (int index) => Row(
            key: ValueKey(tempFiles.toList()[index]),
            children: [
              GestureDetector(
                onTap: () => _showTempActionModal(tempFiles.toList()[index]),
                child: _getTempImageView(tempFiles.toList()[index]),
              ),
            ],
          ),
        ),
      );
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

  //Saved Temp Support
  void _saveTempSupportData() {
    Map<String, dynamic> data = {
      'data': {
        'name': nameController.text,
        'email': emailController.text,
        'country_call_code':
            phoneNumberController.text.isNotEmpty ? countryCallCode : null,
        'phone_number': phoneNumberController.text.isNotEmpty
            ? phoneNumberController.text.toString()
            : null,
        'issue': issue,
        'message': messageController.text,
      }
    };

    DBUtils.saveNewData(data, DBUtils.tempSupport);
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
              setState(() {
                isLoading = true;
              });
              Loading.showLoading(message: StringConst.loadingText);
              _createContactMessage();
            }
          },
        );
      },
    );
  }
}
