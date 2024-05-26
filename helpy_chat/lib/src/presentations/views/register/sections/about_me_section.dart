part of '../../views.dart';

class AboutMeSection extends StatefulWidget {
  const AboutMeSection({super.key});

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection> {
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
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController otherSpecifyLanguageController =
      TextEditingController();

  Candidate? candidate;
  Country? country;
  int countryCallCode = 65;
  String nationality = '';
  String religion = '';
  String gender = '';
  String residingCountry = '';
  List<String> languageSkillList = [];
  String basePhotoUrl = '';
  String route = '';
  Map? candidateData;
  User? user;
  bool isClicked = false;
  Map<int, MediaFile> tempFiles = {};
  bool clickedExit = false;
  String verifiedType = '';

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getPhotoUrl();
    await _getCandidateData();
    await _initializeData();
  }

  Future<void> _initializeData() async {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }
  }

  Future<void> _getPhotoUrl() async {
    String? data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    if (data != null) {
      basePhotoUrl = data;
    }
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);

    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
      if (candidateData != null) {
        user = UserModel.fromJson(candidateData!);
        if (user != null &&
            candidateData![DBUtils.candidateTableName] == null) {
          _initializeUserData();
        } else {
          _requestCandidateProfile();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
        availableBack: false,
        onWillPop: () async {
          Get.offNamed(rootRoute);
          return false;
        },
        scaffold: _getAboutMeScaffold);
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
          onTap: () {
            route != '' ? Get.back() : Get.offNamed(rootRoute);
          },
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.aboutMeTitle.tr,
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BlocConsumer<CandidateBloc, CandidateState>(
                builder: (_, state) {
              return Column(
                children: [
                  const ProfileStepper(
                    currentIndex: 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _getImageUploadContainer,
                  _getTextField(
                      selfDescriptionController,
                      "${StringConst.enterYourSelfDescriptionText.tr}\n${StringConst.possibleDetailText.tr}",
                      false,
                      6,
                      false,
                      maxLength: 150),
                  _getTextField(
                      expectationController,
                      "${StringConst.enterYourExpectationOfEmployerText.tr}\n${StringConst.possibleDetailText.tr}",
                      false,
                      6,
                      false,
                      maxLength: 150),
                  _getTextField(firstNameController,
                      StringConst.enterFirstNameText, false, 1, true),
                  _getTextField(lastNameController, StringConst.lastNameText,
                      false, 1, false),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _getTextField(emailController, StringConst.emailText.tr,
                          false, 1, _getVerifyMethod(StringConst.emailText.tr),
                          inputType: TextInputType.emailAddress),
                      emailController.text.isNotEmpty
                          ? _getVerifyMethod(StringConst.emailText.tr)
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
                  _getTextField(heightController,
                      StringConst.enterYourHeightText, false, 1, false,
                      inputType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      )),
                  _getTextField(weightController,
                      StringConst.enterYourWeightText, false, 1, false,
                      inputType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false)),
                  _getAboutItems,
                  LanguageSkills(
                    initialList: languageSkillList,
                    onValueChanged: (List<String> valueList) {
                      setState(() {
                        languageSkillList = valueList;
                      });
                    },
                  ),
                  _getTextField(otherSpecifyLanguageController,
                      "Others (Please Specify):", false, 1, false),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              );
            }, listener: (_, state) {
              if (state is CandidateProfileSuccess) {
                if (state.data.data != null) {
                  Candidate data =
                      CandidateModel.fromJson(state.data.data!['data']);
                  setState(() {
                    candidate = data;
                    _initializeCandidateData();
                  });
                }
              }

              if (state is CandidateProfileFail) {
                if (state.message != '') {
                  showErrorSnackBar(state.message);
                }
              }

              if (state is CandidateCreateAboutStepLoading) {
                Loading.showLoading(message: StringConst.loadingText);
              }

              if (state is CandidateCreateAboutStepSuccess) {
                if (state.data.data != null) {
                  Loading.cancelLoading();
                  state.data.data!['data']['token'] = user!.token;
                  DBUtils.saveNewData(
                      state.data.data, DBUtils.candidateTableName);
                  _getCandidateData();
                  clickedExit
                      ? Get.offAllNamed(rootRoute)
                      : Get.toNamed(familyInformationPageRoute);
                }
              }

              if (state is CandidateCreateAboutStepFail) {
                Loading.cancelLoading();
                setState(() {
                  clickedExit = false;
                });
                if (state.message != '') {
                  showErrorSnackBar(state.message);
                }
              }
            })),
      );

  Widget get _getAboutItems => Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _getSpacingTableRow,
          TableRow(children: _getReligionDropDown),
          _getSpacingTableRow,
          TableRow(
            children: _getGenderDropDown,
          ),
          _getSpacingTableRow,
          TableRow(
            children: _getDateOfBirthDropDown,
          ),
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
        StringConst.religionText.tr,
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
        StringConst.genderText.tr,
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
          prefix: ConfigsKeyHelper.genderTypeKey),
    ];
  }

  //Date of Birth Dropdown
  List<Widget> get _getDateOfBirthDropDown {
    return [
      Text(
        StringConst.dateOfBirthText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: dateOfBirthController.text.isEmpty
                ? Border.all(color: AppColors.red)
                : null,
          ),
          child: CustomDatePicker(
            controller: dateOfBirthController,
            enabled: true,
            isInitialDate: false,
            isShowPreviousDate: true,
          ))
    ];
  }

  //Nationality Dropdown
  List<Widget> get _getNationalityDropDown {
    return [
      Text(
        StringConst.nationalityText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),

      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: nationality == '' ? Border.all(color: AppColors.red) : null,
          ),
          child: CountryDropdownItem(
            initialValue: nationality,
            title: '',
            topCountries: kCandidateTopCountries,
            onValueChanged: (String value) {
              setState(() {
                nationality = value;
              });
            },
            prefix: ConfigsKeyHelper.myNationalityKey,
          ))
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  //Residing Country Dropdown
  List<Widget> get _getResidingCountryDropDown {
    return [
      Text(
        StringConst.residingCountryText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      CountryDropdownItem(
        initialValue: residingCountry,
        title: StringConst.residingCountryText,
        topCountries: kCandidateTopCountries,
        onValueChanged: (String value) {
          setState(() {
            residingCountry = value;
          });
        },
        prefix: ConfigsKeyHelper.myNationalityKey,
      )
    ];
  }

  TableRow get _getSpacingTableRow => const TableRow(children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        )
      ]);

  Widget _getTextField(TextEditingController controller, String title,
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
        hintText: title.tr,
      ),
    );
  }

  bool _getVerifyMethod(String title) {
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

  Widget _getVerifyItem(String type) {
    return GestureDetector(
        onTap: () {
          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(emailController.text) &&
              type == 'email') {
            showErrorSnackBar(StringConst.invalidEmailText);
          } else {
            verifiedType = type;
            _verifyMethod(verifiedType);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            StringConst.verifyNowText.tr,
            style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  Future<void> _verifyMethod(String method) async {
    Map<String, String> verifyData = {
      'method': method,
      'email': method == 'email' ? emailController.text.toString() : '',
      'phone_number':
          method == 'sms' ? phoneNumberController.text.toString() : '',
      'country_calling_code': method == 'sms' ? countryCallCode.toString() : '',
      'route': aboutMePageRoute
    };
    var data =
        await Get.toNamed(verifyAccountInfoPageRoute, parameters: verifyData);

    if (data != null) {
      await _getCandidateData();
    }
  }

  Widget get _getImageUploadContainer => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  children: tempFiles.entries
                      .map((e) => GestureDetector(
                            onTap: () => _showTempActionModal(
                                e.key, e.value.mediaThumbnailFilepath ?? ""),
                            child: _getUploadedImageView(
                                e.key,
                                e.value.mediaFilePath ?? "",
                                e.value.mediaThumbnailFilepath ?? ""),
                          ))
                      .toList(),
                ),
                _getImageUploadItem()
              ],
            ),
          ),
          Text(
            StringConst.maxFivePhotoText.tr,
            style: const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
          ),
        ],
      );

  void _requestCandidateProfile() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateRequestParams params = CandidateRequestParams(
        token: candidateData!['token'], userId: candidateData!['user_id']);
    candidateBloc.add(CandidateProfileRequested(params: params));
  }

  void _checkNextValidation(bool isExit) {
    List<String> requiredControllers = [
      firstNameController.text.isNotEmpty
          ? firstNameController.text.toString()
          : '',
      dateOfBirthController.text.isNotEmpty
          ? dateOfBirthController.text.toString()
          : '',
      gender != '' ? gender : '',
      nationality != '' ? nationality : '',
      languageSkillList.isNotEmpty ? languageSkillList.toString() : '',
    ];

    List<String> requiredMessages = [
      StringConst.firstNameText,
      StringConst.dateOfBirthText,
      StringConst.genderText,
      StringConst.nationalityText,
      StringConst.languageSkillsText
    ];

    setState(() {
      isClicked = true;
    });

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
                      nextRoute: familyInformationPageRoute,
                      currentRoute: aboutMePageRoute,
                      isExit: isExit ? true : null),
                ),
              ));
    } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text) &&
        emailController.text.isNotEmpty) {
      showErrorSnackBar(StringConst.invalidEmailText);
    } else if (phoneNumberController.text.isNotEmpty &&
        (phoneNumberController.text.length < 7 ||
            phoneNumberController.text.length > 20)) {
      showErrorSnackBar(StringConst.invalidPhoneNumber);
    } else {
      _createCandidateAbout();
    }
  }

  //Create Candidate About API
  void _createCandidateAbout() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateCreateAboutRequestParams params =
        CandidateCreateAboutRequestParams(
      token: candidateData!['token'],
      userId: candidateData!['user_id'],
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text.isNotEmpty ? emailController.text : null,
      countryCallingCode: phoneNumberController.text.isNotEmpty
          ? countryCallCode.toString()
          : null,
      phoneNumber: phoneNumberController.text.isNotEmpty
          ? phoneNumberController.text.toString()
          : null,
      weight: weightController.text.isNotEmpty
          ? double.parse(double.parse(weightController.text).toStringAsFixed(2))
          : null,
      height: heightController.text.isNotEmpty
          ? double.parse(double.parse(heightController.text).toStringAsFixed(2))
          : null,
      expectEmployer: expectationController.text,
      selfDesc: selfDescriptionController.text,
      gender: gender,
      religion: religion,
      nationality: nationality,
      countryOfResidence: residingCountry,
      dateOfBirth: _getFormatDate(dateOfBirthController.text),
      proficientEnglish: languageSkillList.contains('Proficient English'),
      chineseMandarin: languageSkillList.contains('Chinese Mandarin'),
      bahasaMelayu: languageSkillList.contains('Bahasa Melayu'),
      tamil: languageSkillList.contains('Tamil'),
      hokkien: languageSkillList.contains('Hokkien'),
      teochew: languageSkillList.contains('Tecochew'),
      cantonese: languageSkillList.contains('Cantonese'),
      bahasaIndonesian: languageSkillList.contains('Bahasa Indonesian'),
      japanese: languageSkillList.contains('Japanese'),
      korean: languageSkillList.contains('Korean'),
      french: languageSkillList.contains('French'),
      german: languageSkillList.contains('German'),
      arabic: languageSkillList.contains('Arabic'),
      othersSpecify: otherSpecifyLanguageController.text,
      updateProgress:
          candidateData![DBUtils.candidateTableName] == null ? 1 : 0,
      portfolios: tempFiles.isNotEmpty
          ? tempFiles.values
              .where((element) =>
                  !element.mediaThumbnailFilepath!.startsWith("dh/"))
              .map((mediaFile) => File(mediaFile.mediaThumbnailFilepath!))
              .toList()
          : null,
      thumbnails: tempFiles.isNotEmpty
          ? tempFiles.values
              .where((element) =>
                  !element.mediaThumbnailFilepath!.startsWith("dh/"))
              .map((mediaFile) => File(mediaFile.mediaThumbnailFilepath!))
              .toList()
          : null,
      media: tempFiles.isEmpty ? null : tempFiles.keys.join(','),
    );

    candidateBloc.add(CandidateCreateAboutRequested(params: params));
  }

  void _aboutMeImage() {
    tempFiles.clear();
    if (candidate != null && candidate!.media != null) {
      final mediaFileList = candidate!.media ?? [];
      for (var element in mediaFileList) {
        tempFiles[element.id ?? 1] = element;
      }
    }
  }

  //Uploaded ImageView
  Widget _getUploadedImageView(int id, String data, String thumbnail) {
    final bool isVideo = data.contains(".mp4");
    return GestureDetector(
      onTap: () => _showMediaActionModal(id, data),
      child: CustomImageView(
          height: 102,
          width: 102,
          image: thumbnail,
          isVideo: isVideo,
          margin: const EdgeInsets.only(right: 10.0),
          radius: BorderRadius.circular(10),
          fileImage: File(data),
          fit: BoxFit.cover),
    );
  }

  //Image Upload Item
  Widget _getImageUploadItem() {
    final int count = tempFiles.length;
    return count < 5
        ? GestureDetector(
            key: const ValueKey('upload'),
            onTap: () async {
              DateTime now = DateTime.now();
              final int currentSecond = now.millisecond;
              final File? file = await UploadMedia.uploadMediaData(context,
                  isOnlyPhoto: false);
              if (file != null) {
                setState(() {
                  tempFiles[currentSecond] = MediaFile(
                      mediaFilePath: file.path,
                      mediaThumbnailFilepath: file.path);
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
            key: ValueKey('upload'),
          );
  }

  Widget get _getPhoneNumber => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: 160,
              child: PhoneNumberDropdownItem(
                  initialValue: countryCallCode.toString(),
                  title: StringConst.countryText,
                  onValueChanged: (Country value) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        country = value;
                        countryCallCode = int.parse(country!.dialCode ?? '65');
                      });
                    });
                  },
                  isCallCode: true,
                  prefix: ConfigsKeyHelper.profileStep1PhoneKey),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: _getTextField(
                  phoneNumberController,
                  StringConst.phoneNumberOnlyText,
                  false,
                  1,
                  _getVerifyMethod(StringConst.phoneNumberOnlyText),
                  inputType: TextInputType.number)),
        ],
      );

  //Initialize Candidate data
  void _initializeCandidateData() {
    firstNameController.text = candidate!.user!.firstName ?? '';
    lastNameController.text = candidate!.user!.lastName ?? '';
    emailController.text = candidate!.user!.email ?? '';
    phoneNumberController.text =
        user!.phoneNumber != null ? user!.phoneNumber.toString() : '';
    countryCallCode = candidate!.user!.countryCallingCode ?? 65;
    otherSpecifyLanguageController.text = candidate!.othersSpecify ?? '';
    selfDescriptionController.text = candidate!.selfDesc ?? '';
    expectationController.text = candidate!.expectEmployer ?? '';
    weightController.text = candidate!.weight != null
        ? (double.parse(candidate!.weight.toString()) / 1000).toStringAsFixed(2)
        : '';
    heightController.text = candidate!.height != null
        ? (double.parse(candidate!.height.toString()) / 100).toStringAsFixed(2)
        : '';
    dateOfBirthController.text = candidate!.dateOfBirth ?? '';
    residingCountry = candidate!.user!.countryOfResidence ?? '';
    nationality = candidate!.user!.nationality ?? '';
    gender = candidate!.user!.gender ?? '';
    religion = candidate!.user!.religion ?? '';
    _addLanguages();
    _aboutMeImage();
  }

  //Initialize User data
  void _initializeUserData() {
    if (user != null) {
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

  //Action Modal
  void _showMediaActionModal(int id, String mediaFile) {
    final bool isNetwork = mediaFile.startsWith("dh/");
    showCupertinoModalPopup<void>(
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
                'View ${!mediaFile.contains('.mp4') ? 'Image' : 'Video'}',
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await openUploadPreview(
                    context: context,
                    file: File(
                        isNetwork ? "$basePhotoUrl/$mediaFile" : mediaFile),
                    isPreview: true,
                    isVideo: mediaFile.contains('.mp4') ? true : false);
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                StringConst.deleteText.tr,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  tempFiles.removeWhere((key, value) => key == id);
                });
              },
            ),
          ]),
    );
  }

  void _addLanguages() {
    if (candidate!.proficientEnglish!) {
      languageSkillList.add('Proficient English');
    }
    if (candidate!.chineseMandarin!) {
      languageSkillList.add('Chinese Mandarin');
    }
    if (candidate!.bahasaMelayu!) {
      languageSkillList.add('Bahasa Melayu');
    }
    if (candidate!.tamil!) {
      languageSkillList.add('Tamil');
    }
    if (candidate!.hokkien!) {
      languageSkillList.add('Hokkien');
    }
    if (candidate!.teochew!) {
      languageSkillList.add('Tecochew');
    }
    if (candidate!.cantonese!) {
      languageSkillList.add('Cantonese');
    }
    if (candidate!.bahasaIndonesian!) {
      languageSkillList.add('Bahasa Indonesian');
    }
    if (candidate!.japanese!) {
      languageSkillList.add('Japanese');
    }
    if (candidate!.korean!) {
      languageSkillList.add('Korean');
    }
    if (candidate!.french!) {
      languageSkillList.add('French');
    }
    if (candidate!.german!) {
      languageSkillList.add('German');
    }
  }

  String _getFormatDate(String date) {
    return date.replaceAll('T00:00:00.000000Z', '');
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
  _showTempActionModal(int id, String tempFile) {
    final bool isPreview = tempFile.startsWith("dh/");
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
              onPressed: () {
                Navigator.pop(context);
                openUploadPreview(
                    context: context,
                    file:
                        File(isPreview ? tempFile : "$basePhotoUrl/$tempFile"),
                    isPreview: true,
                    isVideo: ImageUtils.isVideoFilepath(tempFile) ?? false);
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
                  tempFiles.removeWhere((key, value) => key == id);
                });
              },
            ),
          ]),
    );
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

  @override
  void dispose() {
    Loading.cancelLoading();
    otherSpecifyLanguageController.dispose();
    endDateController.dispose();
    startDateController.dispose();
    dateOfBirthController.dispose();
    weightController.dispose();
    heightController.dispose();
    religionController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    expectationController.dispose();
    selfDescriptionController.dispose();
    FocusScope.of(context).unfocus();
    super.dispose();
  }
}
