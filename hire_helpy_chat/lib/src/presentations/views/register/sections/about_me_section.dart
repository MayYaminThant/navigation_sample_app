part of '../../views.dart';

class AboutMeSection extends StatefulWidget {
  const AboutMeSection({super.key});

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection> {
  ScrollController scrollController = ScrollController();
  var phoneVerifyKey = GlobalKey();
  final TextEditingController selfDescriptionController =
      TextEditingController();
  final TextEditingController expectationController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Employer? employer;
  Country? country;
  int countryCallCode = 65;
  String nationality = '';
  String religion = '';
  String gender = '';
  String residingCountry = '';
  List<String> languageSkillList = [];
  String basePhotoUrl = '';
  String route = '';
  Map? employerData;
  User? user;
  bool isClicked = false;
  List<String> tempFiles = [];
  List<MediaFile> mediaFileList = [];
  bool isImageDelete = false;
  List<Widget> imageWidgetList = [];
  bool clickedExit = false;
  String verifiedType = '';
  Map? tempEmployerData;

  @override
  void initState() {
    _getPhotoUrl();
    _getCandidateData();
    _initializeData();
    super.initState();
  }

  _initializeData() async {
    tempFiles = await _getTempFilesData() ?? [];
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';

      final String scrollToPosition = Get.parameters['scrollTo'] ?? '';

      if (scrollToPosition == 'verifyPhone') {
        Future.delayed(const Duration(milliseconds: 500), () {
          Scrollable.ensureVisible(
            phoneVerifyKey.currentContext!,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }

      String tempFilePath = Get.parameters['file'] ?? '';
      if (tempFilePath != '') {
        _saveTempFile(tempFilePath);
      }
    }

    if (tempFiles.isNotEmpty) {
      _getTempImages();
    }

    tempEmployerData = await _getTempEmployerData();
    if (tempEmployerData != null) {
      _initializeTempData();
    }
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    basePhotoUrl = data;
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);

    setState(() {
      employerData = box.get(DBUtils.employerTableName);
      user = UserModel.fromJson(employerData!);
      if (user != null && employerData![DBUtils.employerTableName] == null) {
        _initializeUserData();
      } else {
        _requestEmployerProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return BackgroundScaffold(
          onWillPop: _backButtonPressed, scaffold: _getAboutMeScaffold);
    }, listener: (_, state) {
      if (state is EmployerProfileSuccess) {
        if (state.data.data != null) {
          Employer data = EmployerModel.fromJson(state.data.data!['data']);

          setState(() {
            employer = data;
            _initializeEmployerData();
            _aboutMeImage();
          });
        }
      }

      if (state is EmployerProfileFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerCreateAboutStepLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }

      if (state is EmployerCreateAboutStepSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();

          state.data.data!['data']['token'] = employerData!['token'];
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);
          _getCandidateData();

          _clearTempData();
          setState(() {
            tempFiles = [];
            imageWidgetList = [];
          });
          if (!isImageDelete) {
            clickedExit
                ? Get.offAllNamed(rootRoute)
                : Get.toNamed(familyInformationPageRoute);
          } else {
            setState(() {
              isImageDelete = false;
            });
          }
        }
      }

      if (state is EmployerCreateAboutStepFail) {
        Loading.cancelLoading();
        setState(() {
          clickedExit = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerCheckVerifiedSuccess) {
        Loading.cancelLoading();
        _verifyMethod(verifiedType);
      }

      if (state is EmployerCheckVerifiedFail) {
        Loading.cancelLoading();
        setState(() {
          verifiedType = '';
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Scaffold get _getAboutMeScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: _getAboutMeContainer,
      bottomNavigationBar: BottomNavigationItem(
          isNoBack: true,
          onNextButtonPressed: () => _checkNextValidation(false),
          onSaveAndQuitButtonPressed: () {
            setState(() {
              clickedExit = true;
            });
            _checkNextValidation(true);
          }),
    );
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
        title: Text(
          StringConst.aboutMeTitle,
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

  Widget get _getAboutMeContainer => SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const ProfileStepper(
                currentIndex: 0,
              ),
              const SizedBox(
                height: 10,
              ),
              //TODO
              _getImageUploadContainer,
              _getTextField(
                  selfDescriptionController,
                  "${'Enter Your Self Description'.tr}\n${'*Please be as detailed as possible'.tr}",
                  false,
                  6,
                  false,
                  maxLength: 150),
              _getTextField(
                  expectationController,
                  "${'Enter Your Self Expectation Of Candidate'.tr}\n${'*Please be as detailed as possible'.tr}",
                  false,
                  6,
                  false,
                  maxLength: 150),
              _getTextField(firstNameController, "Enter Your First Name".tr,
                  false, 1, true),
              _getTextField(lastNameController, "Enter Your Last Name".tr,
                  false, 1, true),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _getTextField(
                      emailController, "Email Address".tr, false, 1, true,
                      inputType: TextInputType.emailAddress),
                  emailController.text.isNotEmpty
                      ? _getVerifyMethod(StringConst.emailText)
                          ? _getVerifyItem('email')
                          : _getVerified
                      : const SizedBox.shrink()
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _getPhoneNumber,
                  phoneNumberController.text.isNotEmpty
                      ? _getVerifyMethod(StringConst.phoneNumberOnlyText)
                          ? _getVerifyItem('sms')
                          : _getVerified
                      : const SizedBox.shrink()
                ],
              ),
              _getAboutItems,
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );

  _backButtonPressed() {
    _clearTempData();
    if (route == hiringPageRoute) {
      Get.offNamed(hiringPageRoute);
      return;
    }
    route != '' ? Get.back() : Get.offNamed(rootRoute);
  }

  _getVerifyMethod(String title) {
    if (phoneNumberController.text.isNotEmpty &&
        title == StringConst.phoneNumberOnlyText &&
        (phoneNumberController.text.toString() !=
                (user!.phoneNumber.toString()) ||
            countryCallCode != (user!.countryCallingCode ?? 65) ||
            user!.phoneNumberVerifiedDateTime == null)) {
      return true;
    } else if (emailController.text.isNotEmpty &&
        title == StringConst.emailText &&
        (emailController.text != user!.email.toString() ||
            user!.emailVerifiedDateTime == null)) {
      return true;
    } else {
      return false;
    }
  }

  _getVerifyItem(String type) {
    return GestureDetector(
        onTap: () => _checkVerifiedValidation(type),
        child: const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            StringConst.verifyNowText,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  _verifyMethod(String method) async {
    var data = await Get.toNamed(verifyAccountInfoPageRoute, parameters: {
      'method': method,
      'email': method == 'email' ? emailController.text.toString() : '',
      'phone_number':
          method == 'sms' ? phoneNumberController.text.toString() : '',
      'country_calling_code': method == 'sms' ? countryCallCode.toString() : '',
      'route': aboutMePageRoute
    });

    if (data != null) {
      _getCandidateData();
    }
  }

  Widget get _getAboutItems => Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _getSpacingTableRow,
          TableRow(
            children: _getGenderDropDown,
          ),
          _getSpacingTableRow,
          TableRow(children: _getReligionDropDown),
          _getSpacingTableRow,
          TableRow(
            children: _getNationalityDropDown,
          ),
          _getSpacingTableRow,
          TableRow(
            children: _getResidingCountryDropDown,
          ),
          _getSpacingTableRow,
          // TableRow(
          //   children: _getStartDateDropDown,
          // ),
          // _getSpacingTableRow,
          // TableRow(
          //   children: _getEndDateDropDown,
          // )
        ],
      );

  //Religion Dropdown
  List<Widget> get _getReligionDropDown {
    return [
      Text(
        StringConst.religionText,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      ReligionDropdownItem(
        initialValue: religion,
        title: '',
        onValueChanged: (String data) {
          setState(() {
            religion = data;
          });
        },
        iconPadding: 0,
        prefix: ConfigsKeyHelper.profileStep1ReligionKey,
      )
    ];
  }

  //Gender Dropdown
  List<Widget> get _getGenderDropDown {
    return [
      Text(
        StringConst.genderText,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),

      DropdownItem(
        initialValue: gender,
        title: '',
        onValueChanged: (String value) {
          setState(() {
            gender = value;
          });
        },
        datas: const [],
        suffixIcon: Iconsax.arrow_down5,
        prefix: ConfigsKeyHelper.genderTypeKey,
        isRequired: true,
      )
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  //Nationality Dropdown
  List<Widget> get _getNationalityDropDown {
    return [
      Text(
        'Nationality'.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),

      CountryDropdownItem(
        initialValue: nationality,
        title: 'Nationality'.tr,
        topCountries: kEmployerTopCountries,
        onValueChanged: (String value) {
          setState(() {
            nationality = value;
          });
        },
        prefix: ConfigsKeyHelper.myNationalityKey,
      )
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  //Residing Country Dropdown
  List<Widget> get _getResidingCountryDropDown {
    return [
      Text(
        'Residing Country'.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),

      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                residingCountry == '' ? Border.all(color: AppColors.red) : null,
          ),
          child: CountryDropdownItem(
            initialValue: residingCountry,
            title: "Residing Country".tr,
            topCountries: kEmployerTopCountries,
            onValueChanged: (String value) {
              setState(() {
                residingCountry = value;
              });
            },
            prefix: ConfigsKeyHelper.myNationalityKey,
          ))
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  //Start Date
  // List<Widget> get _getStartDateDropDown {
  //   return [
  //     const Text(
  //       'Earliest Start date',
  //       style: TextStyle(color: AppColors.white, fontSize: 16),
  //     ),
  //     CustomDatePicker(
  //       controller: startDateController,
  //       enabled: true,
  //       isInitialDate: true,
  //       isShowPreviousDate: true,
  //     ),
  //   ];
  // }

  //End date
  // List<Widget> get _getEndDateDropDown {
  //   return [
  //     const Text(
  //       'End date',
  //       style: TextStyle(color: AppColors.white, fontSize: 16),
  //     ),

  //     CustomDatePicker(
  //       controller: endDateController,
  //       enabled: true,
  //       isInitialDate: true,
  //       isShowPreviousDate: true,
  //     )
  //     //DropdownButton(items: {}, onChanged: onChanged)
  //   ];
  // }

  TableRow get _getSpacingTableRow => const TableRow(children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        )
      ]);

  _getTextField(TextEditingController controller, String title,
      bool hasSuffixIcon, int? maxLine, bool isRequired,
      {TextInputType? inputType, int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: CustomTextField(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: controller.text.isEmpty && isRequired
              ? Border.all(color: AppColors.red)
              : const GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    Color(0xFFFFB6A0),
                    Color(0xFFA5E3FD),
                    Color(0xFF778AFF),
                    Color(0xFFFFCBF2),
                  ]),
                  width: 1,
                ),
          color: AppColors.cardColor.withOpacity(0.1),
        ),
        maxLine: maxLine ?? 1,
        maxLength: maxLength,
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
        hasSuffixIcon: hasSuffixIcon,
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
        hintTextStyle: const TextStyle(
            color: AppColors.primaryGrey, fontSize: Sizes.textSize14),
        textStyle: const TextStyle(color: AppColors.primaryGrey),
        hintText: title,
      ),
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

  void _requestEmployerProfile() {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerRequestParams params = EmployerRequestParams(
        token: employerData!['token'], userId: employerData!['user_id']);
    candidateBloc.add(EmployerProfileRequested(params: params));
  }

  _checkNextValidation(bool isExit) {
    List<String> requiredControllers = [
      firstNameController.text.isNotEmpty
          ? firstNameController.text.toString()
          : '',
      gender != '' ? gender : '',
      residingCountry != '' ? residingCountry : '',
    ];

    List<String> requiredMessages = [
      StringConst.firstNameText,
      StringConst.genderText,
      "Residing Country",
      StringConst.languageSkillsText
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
                          nextRoute: familyInformationPageRoute,
                          currentRoute: aboutMePageRoute,
                          isExit: isExit ? true : null),
                    );
                  },
                ),
              ));
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      showErrorSnackBar(StringConst.invalidEmailText);
    } else if (phoneNumberController.text.isNotEmpty &&
        (phoneNumberController.text.length < 7 ||
            phoneNumberController.text.length > 20)) {
      showErrorSnackBar(StringConst.invalidPhoneNumber);
    } else if (gender == '') {
      showErrorSnackBar(StringConst.invalidGenderText);
    } else {
      _createEmployerAbout();
    }
  }

  //Create Employer About API
  void _createEmployerAbout() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerCreateAboutRequestParams params = EmployerCreateAboutRequestParams(
      token: employerData!['token'],
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text.isNotEmpty ? emailController.text : null,
      countryCallingCode: phoneNumberController.text.isNotEmpty
          ? countryCallCode.toString()
          : null,
      phoneNumber: phoneNumberController.text.isNotEmpty
          ? phoneNumberController.text.toString()
          : null,
      expectEmployer: expectationController.text,
      selfDesc: selfDescriptionController.text,
      gender: gender,
      religion: religion,
      nationality: nationality,
      countryOfResidence: residingCountry,
      updateProgress: employerData![DBUtils.employerTableName] == null ? 1 : 0,
      portfolios: tempFiles.isNotEmpty
          ? List<File>.generate(
              tempFiles.length, (int index) => File(tempFiles[index]))
          : null,
      media: _getMediaFiles() ?? '',
    );

    employerBloc.add(EmployerCreateAboutRequested(params: params));
  }

  _getTempImages() {
    imageWidgetList.addAll(List<Widget>.generate(
        tempFiles.length,
        (int index) => Row(
              key: ValueKey(tempFiles[index]),
              children: [
                GestureDetector(
                  onTap: () => _showTempActionModal(tempFiles[index]),
                  child: _getTempImageView(tempFiles[index]),
                ),
              ],
            )));
  }

  _aboutMeImage() {
    if (employer != null && employer!.media != null) {
      mediaFileList = employer!.media ?? [];
      imageWidgetList.addAll(List.generate(
          mediaFileList.length,
          (int index) => Row(
                key: ValueKey(mediaFileList[index]),
                children: [
                  _getUploadedImageView(mediaFileList[index]),
                ],
              )));
    } else {
      return [];
    }
  }

  //Uploaded ImageView
  _getUploadedImageView(MediaFile data) => GestureDetector(
      onTap: () => _showMediaActionModal(data),
      child: data.mediaFilePath!.contains('.mp4')
          ? FutureBuilder<Uint8List?>(
              future: getVideoThumbnail('$basePhotoUrl/${data.mediaFilePath!}'),
              builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
                if (snapshot.connectionState ==
                    k_connection_state.ConnectionState.waiting) {
                  return Container(
                      height: 102,
                      margin: const EdgeInsets.only(right: 10.0),
                      width: 102,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.greyBg.withOpacity(0.1),
                      ),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )));
                }
                if (snapshot.hasData) {
                  return getDecorationImage(
                      MemoryImage(snapshot.data!), true, data.mediaFilePath!);
                }
                return const Text("error");
              },
            )
          : CachedNetworkImage(
              imageUrl: '$basePhotoUrl/${data.mediaFilePath ?? ''}',
              imageBuilder: (context, imageProvider) =>
                  getDecorationImage(imageProvider, false, data.mediaFilePath!),
              placeholder: (context, url) => const SizedBox(
                width: 112,
                height: 102,
                child: Center(child: CircularProgressIndicator()),
              ),
            ));

  _getTempImageView(String path) =>
      !path.contains('.mp4') && !path.contains('.mov')
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

  //Image Upload Item
  _getImageUploadItem() {
    int mediaLength = employer != null && employer!.media != null
        ? employer!.media!.length
        : 0;
    int count = tempFiles.length + mediaLength;
    return count < 5
        ? GestureDetector(
            key: const ValueKey('upload'),
            onTap: () {
              _saveTempEmployerData();
              showDialog(
                  context: context,
                  builder: (context) => const UpdatePhotoModal(
                        route: aboutMePageRoute,
                        isOnlyPhoto: false,
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
            key: ValueKey('upload'),
          );
  }

  Widget get _getPhoneNumber => Row(
        key: phoneVerifyKey,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: 130,
              child: PhoneNumberDropdownItem(
                initialValue: countryCallCode.toString(),
                title: 'Country'.tr,
                onValueChanged: (Country value) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      country = value;
                      countryCallCode = int.parse(country!.dialCode ?? '65');
                    });
                  });
                },
                isCallCode: true,
                prefix: ConfigsKeyHelper.profileStep1PhoneKey,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: _getTextField(phoneNumberController,
                  StringConst.phoneNumberOnlyText, false, 1, false,
                  inputType: TextInputType.number)),
        ],
      );

  //Initialize Employer data
  void _initializeEmployerData() {
    firstNameController.text = employer!.user!.firstName ?? '';
    lastNameController.text = employer!.user!.lastName ?? '';
    emailController.text = employer!.user!.email ?? '';
    phoneNumberController.text =
        user!.phoneNumber != null ? user!.phoneNumber.toString() : '';
    countryCallCode = employer!.user!.countryCallingCode ?? 65;
    gender = employer!.user!.gender ?? '';
    residingCountry = employer!.user!.countryOfResidence ?? '';
    if (tempEmployerData == null) {
      selfDescriptionController.text = employer!.selfDesc ?? '';
      expectationController.text = employer!.expectCandidate ?? '';
      nationality = employer!.user!.nationality ?? '';
      religion = employer!.user!.religion ?? '';
    }
  }

  //Initialize User data
  void _initializeUserData() {
    firstNameController.text = user!.firstName ?? '';
    lastNameController.text = user!.lastName ?? '';
    emailController.text = user!.email ?? '';
    countryCallCode = user!.countryCallingCode ?? 65;
    nationality = user!.nationality ?? '';
    gender = user!.gender ?? '';
    religion = user!.religion ?? '';
    phoneNumberController.text =
        user!.phoneNumber != null ? user!.phoneNumber.toString() : '';
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

  //Action Modal
  _showMediaActionModal(MediaFile mediaFile) => showCupertinoModalPopup<void>(
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
                    isImageDelete = true;
                    int index = imageWidgetList.indexWhere((item) =>
                        item.key.toString().contains(mediaFile.mediaFilePath!));
                    imageWidgetList.removeAt(index);
                    mediaFileList.remove(mediaFile);
                  });
                  _createEmployerAbout();
                },
              ),
            ]),
      );

  _getPopupHeight(List<TextEditingController> requiredControllers) {
    double height = 210.0;
    for (int i = 0; i < requiredControllers.length; i++) {
      if (requiredControllers[i].text.isEmpty) height += 30;
    }
    return height;
  }

  void _saveTempFile(String tempFilePath) async {
    tempFiles.add(tempFilePath);
    DBUtils.saveListData(tempFiles, DBUtils.tempFiles);
  }

  //Get Temp Files Data
  _getTempFilesData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    return box.get(DBUtils.tempFiles);
  }

  _getVideoImage(String path) {
    return FutureBuilder<Uint8List?>(
      future: getVideoThumbnail(path),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return getDecorationImage(MemoryImage(snapshot.data!), true, path);
        }
        return const Text("error");
      },
    );
  }

  _getMediaFiles() {
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
                  'View ${!tempFile.contains('.mp4') && !tempFile.contains('.mov') ? 'Image' : 'Video'}',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Get.toNamed(
                      !tempFile.contains('.mp4') && !tempFile.contains('.mov')
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

  void _requestCheckVerified() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerCheckVerifiedRequestParams params =
        EmployerCheckVerifiedRequestParams(
      type: verifiedType == 'sms' ? 'phone' : 'email',
      email: verifiedType == 'email' ? emailController.text.toString() : null,
      phoneNumber: verifiedType == 'sms'
          ? int.parse(phoneNumberController.text.toString())
          : null,
      countryCode:
          verifiedType == 'sms' ? int.parse(countryCallCode.toString()) : null,
    );
    employerBloc.add(EmployerCheckVerifiedRequested(params: params));
  }

  _checkVerifiedValidation(String type) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text) &&
        type == 'email') {
      showErrorSnackBar(StringConst.invalidEmailText);
    } else if (phoneNumberController.text.isNotEmpty &&
        (phoneNumberController.text.length < 7 ||
            phoneNumberController.text.length > 20)) {
      showErrorSnackBar(StringConst.invalidPhoneNumber);
    } else {
      setState(() {
        verifiedType = type;
      });
      _requestCheckVerified();
      Loading.showLoading(message: StringConst.loadingText);
    }
  }

  //Verified
  Widget get _getVerified => const Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          'Verified',
          style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      );

  //Saved Temp Employer
  void _saveTempEmployerData() {
    Map<String, dynamic> data = {
      'data': {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': _getVerifyMethod(StringConst.emailText)
            ? emailController.text
            : null,
        'countryCallingCode':
            _getVerifyMethod(StringConst.phoneNumberOnlyText) &&
                    phoneNumberController.text.isNotEmpty
                ? countryCallCode.toString()
                : null,
        'phoneNumber': _getVerifyMethod(StringConst.phoneNumberOnlyText) &&
                phoneNumberController.text.isNotEmpty
            ? phoneNumberController.text.toString()
            : null,
        'weight': weightController.text,
        'height': heightController.text,
        'expectEmployer': expectationController.text,
        'selfDesc': selfDescriptionController.text,
        'gender': gender,
        'religion': religion,
        'nationality': nationality,
        'countryOfResidence': residingCountry,
      }
    };

    DBUtils.saveNewData(data, DBUtils.tempEmployer);
  }

  //Get Temp Employer Data
  _getTempEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    return box.get(DBUtils.tempEmployer);
  }

  //InitializeTempData
  _initializeTempData() async {
    setState(() {
      selfDescriptionController.text = tempEmployerData!['selfDesc'] ?? '';
      expectationController.text = tempEmployerData!['expectEmployer'] ?? '';
      weightController.text = tempEmployerData!['weight'] ?? '';
      heightController.text = tempEmployerData!['height'] ?? '';
      residingCountry = tempEmployerData!['countryOfResidence'] ?? '';
      nationality = tempEmployerData!['nationality'] ?? '';
      gender = tempEmployerData!['gender'] ?? '';
      religion = tempEmployerData!['religion'] ?? '';
      languageSkillList = tempEmployerData!['language'] ?? [];
    });
  }

  //Clear TempData
  void _clearTempData() {
    DBUtils.clearData(DBUtils.tempFiles);
    DBUtils.clearData(DBUtils.tempEmployer);
  }
}
