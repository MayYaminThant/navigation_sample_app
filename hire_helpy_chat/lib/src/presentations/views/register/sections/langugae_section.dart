part of '../../views.dart';

class LanguageSection extends StatefulWidget {
  const LanguageSection({super.key});

  @override
  State<LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends State<LanguageSection> {
  final TextEditingController otherSpecifyLanguageController =
      TextEditingController();

  Map? employerData;
  Employer? employer;
  List<String> languageSkillList = [];
  List<String> initialSkillList = [];
  bool clickedExit = false;
  String route = '';

  @override
  void initState() {
    _getEmployerData();
    _initializeData();
    super.initState();
  }

  _initializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
    if (employerData![DBUtils.employerTableName] != null) {
      _requestEmployerProfile();
    }
  }

  void _requestEmployerProfile() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerRequestParams params = EmployerRequestParams(
        token: employerData!['token'], userId: employerData!['user_id']);
    employerBloc.add(EmployerProfileRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return BackgroundScaffold(
          onWillPop: _backButtonPressed,
          scaffold: _getSkillAndQualificationScaffold);
    }, listener: (_, state) {
      if (state is EmployerProfileSuccess) {
        if (state.data.data != null) {
          Employer data = EmployerModel.fromJson(state.data.data!['data']);
          setState(() {
            employer = data;
            _initializeCandidateData();
          });
        }
      }

      if (state is EmployerProfileFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerUpdateLanguageLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }

      if (state is EmployerUpdateLanguageSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          state.data.data!['data']['token'] = employerData!['token'];
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);
          clickedExit
              ? Get.offAllNamed(rootRoute)
              : Get.toNamed(profileCreationSuccessPageRoute);
        }
      }

      if (state is EmployerUpdateLanguageFail) {
        Loading.cancelLoading();
        setState(() {
          clickedExit = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Scaffold get _getSkillAndQualificationScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: _getSkillAndQualificationContainer,
      bottomNavigationBar: BottomNavigationItem(
          onNextButtonPressed: () => _checkValidation(),
          nextButtonText: "Finish Now".tr,
          onSaveAndQuitButtonPressed: () {
            setState(() {
              clickedExit = true;
            });
            _checkValidation();
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
          StringConst.languageInformationText.tr,
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

  Widget get _getSkillAndQualificationContainer => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const ProfileStepper(
                currentIndex: 2,
              ),
              LanguageSkills(
                initialList: languageSkillList,
                onValueChanged: (List<String> valueList) {
                  setState(() {
                    languageSkillList = valueList;
                  });
                },
              ),
              _getTextField(otherSpecifyLanguageController,
                  "Others (Please Specify):", false, 1),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );

  _backButtonPressed() {
    route != '' ? Get.back() : Get.offNamed(rootRoute);
  }

  _getTextField(
    TextEditingController controller,
    String title,
    bool hasSuffixIcon,
    int? maxLine,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: CustomTextField(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.cardColor.withOpacity(0.1)),
        maxLine: maxLine ?? 1,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
        controller: controller,
        textInputType: TextInputType.text,
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
        hintTextStyle:
            const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
        textStyle: const TextStyle(color: AppColors.primaryGrey),
        hintText: title,
      ),
    );
  }

  _checkValidation() {
    if (languageSkillList.isNotEmpty) {
      _createCandidateHighestQualification();
    } else {
      showErrorSnackBar("Please choose at least one language");
    }
  }

  //Create Employer Language
  void _createCandidateHighestQualification() {
    print("LOOK");
    print(otherSpecifyLanguageController.text);
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerUpdateLanguageParams params = EmployerUpdateLanguageParams(
        token: employerData!['token'],
        userId: employerData!['user_id'],
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
        updateProgress: _getUpdateProgress());

    //print('perams ${initialSkillList} ${params.updateProgress}');
    employerBloc.add(EmployerUpdateLanguageRequested(params: params));
  }

  void _initializeCandidateData() {
    if (employer != null) {
      _addLanguages(languageSkillList);
      _addLanguages(initialSkillList);
      otherSpecifyLanguageController.text =
          employer!.languageOthersSpecify ?? '';
    }
  }

  void _addLanguages(List<String> data) {
    if (employer!.languageProficientEnglish!) {
      data.add('Proficient English');
    }
    if (employer!.languageChineseMandarin!) {
      data.add('Chinese Mandarin');
    }
    if (employer!.languageBahasaMelayu!) {
      data.add('Bahasa Melayu');
    }
    if (employer!.languageTamil!) {
      data.add('Tamil');
    }
    if (employer!.languageHokkien!) {
      data.add('Hokkien');
    }
    if (employer!.languageTeochew!) {
      data.add('Tecochew');
    }
    if (employer!.languageCantonese!) {
      data.add('Cantonese');
    }
    if (employer!.languageBahasaIndonesian!) {
      data.add('Bahasa Indonesian');
    }
    if (employer!.languageJapanese!) {
      data.add('Japanese');
    }
    if (employer!.languageKorean!) {
      data.add('Korean');
    }
    if (employer!.languageFrench!) {
      data.add('French');
    }
    if (employer!.languageGerman!) {
      data.add('German');
    }
    if (employer!.languageArabic!) {
      data.add('Arabic');
    }
  }

  _getUpdateProgress() {
    if (employer == null) {
      return 1;
    } else if (employer != null && initialSkillList.isNotEmpty) {
      return 1;
    } else {
      return 0;
    }
  }
}
