part of '../../views.dart';

class SkillAndQualificationSection extends StatefulWidget {
  const SkillAndQualificationSection({super.key});

  @override
  State<SkillAndQualificationSection> createState() =>
      _SkillAndQualificationSectionState();
}

class _SkillAndQualificationSectionState
    extends State<SkillAndQualificationSection> {
  final TextEditingController qualificationCommentController =
      TextEditingController();
  final TextEditingController otherSpecifySkillController =
      TextEditingController();

  String _highestQualification = '';
  Map? candidateData;
  Candidate? candidate;
  List<String> skillList = [];
  bool clickedExit = false;
  String route = '';
  String workPermitStatus = 'Unverified';
  String expiryDate = "";
  String? getWorkPermitValue;
  int? workPermitVerificationReward;
  int? workPermitVerificationTime;
  bool workPermitLoading = false;

  @override
  void initState() {
    _getCandidateData();
    _initializeData();
    getWorkPermitValidity();
    getWorkPermitValidationTime();
    super.initState();
  }

  @override
  void dispose() {
    qualificationCommentController.dispose();
    otherSpecifySkillController.dispose();
    super.dispose();
  }

  void _initializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }
  }

  Future<void> getWorkPermitValidity() async {
    var data = await DBUtils.getKeyDataList(
        'DH_CANDIDATE_VERIFY_WORKPERMIT_COIN_REWARD_FOR_REFEREE');
    workPermitVerificationReward = data["amount"];
    final workPermitVal = await StringUtils.getWorkPermitValue();
    if (workPermitVal != null) {
      superPrint(workPermitVal, title: "getWorkPermitValue");
      getWorkPermitValue = "$workPermitVal";
    }
  }

  Future<void> getWorkPermitValidationTime() async {
    var data =
        await DBUtils.getCandidateConfigs('VERIFY_WORK_PERMIT_DELAY_HOUR');
    workPermitVerificationTime = int.parse(data.toString());
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
    if (candidateData != null) {
      _requestCandidateProfile();
    }
  }

  void _requestCandidateProfile() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateRequestParams params = CandidateRequestParams(
        token: candidateData!['token'], userId: candidateData!['user_id']);
    candidateBloc.add(CandidateProfileRequested(params: params));
  }

  void _workPermitLoading(bool value) {
    setState(() {
      workPermitLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return BackgroundScaffold(
          availableBack: true, scaffold: _getSkillAndQualificationScaffold);
    }, listener: (_, state) {
      if (state is CandidateProfileSuccess) {
        if (state.data.data != null) {
          Candidate data = CandidateModel.fromJson(state.data.data!['data']);
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

      if (state is CandidateUpdateSkillQualificationSuccess) {
        if (state.data.data != null) {
          state.data.data!['data']['token'] = candidateData!['token'];
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);

          clickedExit
              ? Get.offAllNamed(rootRoute)
              : Get.toNamed(workExperiencePageRoute);
        }
      }

      if (state is CandidateUpdateSkillQualificationFail) {
        setState(() {
          clickedExit = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateWorkPermitLoading) {
        _workPermitLoading(true);
      }

      if (state is CandidateWorkPermitSuccess) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        _workPermitLoading(false);
        if (state.data.data != null) {
          final wpStatus = state.data.data!['message'];
          if (wpStatus == 'Pending' && (workPermitVerificationTime ?? 0) > 0) {
            showInfoModal(
                title: "Your Work Permit will take @vTime hours to verify."
                    .trParams({
                  'vTime': (workPermitVerificationTime ?? 0).toString()
                }),
                message:
                    "If successfully verified, your account will be credited with @vReward Phluid Coins. Please check back soon."
                        .trParams({
                  'vReward': (workPermitVerificationReward ?? 0).toString()
                }),
                type: 'info');
          }
          if (wpStatus == 'Unverified') {
            showInfoModal(
                title: "Work Permit verification failed.".tr,
                message:
                    "We were unable to verify your work permit. Please enter your details and try again."
                        .tr,
                type: 'error');
          }
          if (wpStatus == 'Verified' || wpStatus == 'Expired') {
            showInfoModal(
                title: "Work Permit verified!".tr,
                message: "Thank you for verifying your work permit!".tr,
                type: 'success');
          }

          setState(() {
            workPermitStatus = wpStatus;
            expiryDate = '${candidate?.workPermit?.expiryDate}';
          });
        }
      }

      if (state is CandidateWorkPermitFail) {
        _workPermitLoading(false);
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        setState(() {
          clickedExit = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getSkillAndQualificationScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: _getSkillAndQualificationContainer,
      bottomNavigationBar: BottomNavigationItem(
          onNextButtonPressed: () => _checkValidation(),
          onSaveAndQuitButtonPressed: () {
            setState(() {
              clickedExit = true;
            });
            _createCandidateHighestQualification();
          }),
    );
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => route != '' ? Get.back() : Get.offNamed(rootRoute),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.skillAndQualificationTitle.tr,
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const ProfileStepper(
                currentIndex: 2,
              ),
              //_getImageUpload(),

              _getSkillAndQualificationItems,
              _getTextField(qualificationCommentController,
                  StringConst.addAnyCommentOnEducationJourneyText, false, 3),

              const SizedBox(
                height: 20,
              ),
              _getWorkPermitValidity,

              EmployeeSkills(
                initialList: skillList,
                onValueChanged: (List<String> value) {
                  setState(() {
                    skillList = value;
                  });
                },
                prefix: ConfigsKeyHelper.profileStep3TaskTypeKey,
              ),

              _getTextField(otherSpecifySkillController,
                  StringConst.skillOthersText, false, 1),

              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );

  Widget get _getSkillAndQualificationItems => Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _getSpacingTableRow,
          TableRow(
            children: _getHighestQualificationDropDown,
          ),
        ],
      );

  //Highest Qualification Dropdown
  List<Widget> get _getHighestQualificationDropDown {
    return [
      Text(
        StringConst.highestQualificationText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      DropdownItem(
        initialValue: _highestQualification,
        title: _highestQualification,
        onValueChanged: (String value) {
          setState(() {
            _highestQualification = value;
          });
        },
        datas: const [],
        prefix: ConfigsKeyHelper.qualificationKey,
        suffixIcon: Iconsax.arrow_down5,
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

  Widget _getTextField(
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
        hintText: title.tr,
      ),
    );
  }

  void _checkValidation() {
    List<String> requiredControllers = [
      _highestQualification,
      skillList.isNotEmpty ? skillList.toString() : '',
    ];

    List<String> requiredMessages = [
      StringConst.highestQualificationText,
      StringConst.skillSetText
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
                    nextRoute: workExperiencePageRoute,
                    currentRoute: skillAndQualificationPageRoute,
                  ),
                ),
              ));
    } else {
      _createCandidateHighestQualification();
    }
  }

  //Create Candidate Highest Qualification
  void _createCandidateHighestQualification() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateUpdateSkillAndQualificationRequestParams params =
        CandidateUpdateSkillAndQualificationRequestParams(
            token: candidateData!['token'],
            highestQualification: _highestQualification,
            educationJourneyDesc: qualificationCommentController.text,
            skillGeneralHousework: skillList.contains('General Housework'),
            skillInfantCare: skillList.contains('Infant Care'),
            skillElderlyCare: skillList.contains('Elderly Care'),
            skillPetCare: skillList.contains('Pet Care'),
            skillCooking: skillList.contains('Cooking'),
            skillSpecialNeedsCare: skillList.contains('Special Needs Care'),
            skillBedriddenCare: skillList.contains('Bedidden Care'),
            skillHandicapCare: skillList.contains('Handicap Care'),
            skillOthersSpecify: otherSpecifySkillController.text,
            updateProgress: _getUpdateProgress());

    candidateBloc
        .add(CandidateUpdateSkillAndQualificationRequested(params: params));
  }

  void _initializeCandidateData() {
    _highestQualification = candidate?.highestQualification ?? '';
    qualificationCommentController.text = candidate?.educationJourneyDesc ?? '';
    workPermitStatus = candidate?.workPermitStatus ?? '';
    expiryDate = '${candidate?.workPermit?.expiryDate}';
    _addEmployeeSkills();
  }

  void _addEmployeeSkills() {
    Map<String, bool?> skills = {
      'General Housework': candidate?.skillGeneralHousework,
      'Infant Care': candidate?.skillInfantCare,
      'Elderly Care': candidate?.skillElderlyCare,
      'Pet Care': candidate?.skillPetCare,
      'Cooking': candidate?.skillCooking,
      'Special Needs Care': candidate?.skillSpecialNeedsCare,
      'Bedridden Care': candidate?.skillbedriddenCare,
      'Handicap Care': candidate?.skillHandicapCare,
    };

    skills.forEach((skillName, skillValue) {
      if (skillValue != null && skillValue) {
        skillList.add(skillName);
      }
    });

    if (candidate?.skillOthersSpecify != null) {
      otherSpecifySkillController.text = candidate?.skillOthersSpecify ?? '';
    }
  }

  // double _getPopupHeight(List<String> requiredControllers) {
  //   double height = 210.0;
  //   for (int i = 0; i < requiredControllers.length; i++) {
  //     if (requiredControllers[i] == '' || requiredControllers[i] == '0') {
  //       height += 30;
  //     }
  //   }
  //   return height;
  // }

  int _getUpdateProgress() {
    if (candidate == null || candidate?.highestQualification == null) {
      return 1;
    }
    return 0;
  }

  //Work Permit
  Widget get _getWorkPermitValidity => IgnorePointer(
      ignoring: workPermitLoading,
      child: Container(
          foregroundDecoration: workPermitLoading
              ? const BoxDecoration(
                  color: Colors.grey,
                  backgroundBlendMode: BlendMode.saturation,
                )
              : null,
          height: isBurmese(StringConst.clickHereAndEarnText.tr) ? 310 : 250,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: AppColors.cardColor.withOpacity(0.1),
              border: Border.all(color: getWorkPermitColor(), width: 1),
              borderRadius: BorderRadius.circular(15.0)),
          child: Stack(children: [
            if (workPermitLoading)
              const Center(child: CircularProgressIndicator()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  StringConst.workPermitValidityText.tr,
                  style: const TextStyle(color: AppColors.white, fontSize: 16),
                ),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {0: FixedColumnWidth(120)},
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '${StringConst.statusText.tr}  -',
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 14),
                        ),
                      ),
                      Row(
                        children: [
                          _getWorkPermitStatus,
                        ],
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '${StringConst.expiryText.tr}  -',
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          candidate != null && candidate?.workPermit != null
                              ? DateFormat('dd MMM, yyyy').format(
                                  DateTime.parse(
                                    expiryDate,
                                  ),
                                )
                              : 'Invalid',
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 14),
                        ),
                      ),
                    ]),
                  ],
                ),
                _getVerifyNowButton
              ],
            )
          ])));

  //Verify Button
  Widget get _getVerifyNowButton {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 80,
        height: isBurmese(StringConst.clickHereAndEarnText.tr) ? 70 : 47,
        child: CustomPrimaryButton(
            text: getWorkPermitValue == null &&
                    (workPermitVerificationReward ?? 0) > 0
                ? clickHereAndEarnTextGenerator(
                    isBurmese(StringConst.clickHereAndEarnText.tr))
                : StringConst.clickHereToVerifyText.tr,
            customColor: workPermitStatus == 'Pending'
                ? AppColors.primaryGrey
                : AppColors.secondaryColor,
            textColor: AppColors.black,
            fontSize: isBurmese(StringConst.clickHereAndEarnText.tr) ? 12 : 14,
            onPressed: () async =>
                workPermitStatus == "Verified" || workPermitStatus != "Pending"
                    ? await _showWorkPermitModal()
                    : null));
  }

  String clickHereAndEarnTextGenerator(bool isBurmese) => isBurmese
      ? "$workPermitVerificationReward ${StringConst.clickHereAndEarnText.tr}"
      : "${StringConst.clickHereAndEarnText.tr} $workPermitVerificationReward PHC";

  bool isBurmese(String input) {
    for (int i = 0; i < input.length; i++) {
      int charCode = input.codeUnitAt(i);
      if ((charCode >= 0x1000 && charCode <= 0x109F) ||
          (charCode >= 0xAA60 && charCode <= 0xAA7F)) {
        return true;
      }
    }
    return false;
  }

  //WorkPermit Status
  Widget get _getWorkPermitStatus => FutureBuilder<dynamic>(
        future: StringUtils.getWorkPermitVerifyDelayValue(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.45,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                  color: getWorkPermitColor(),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                snapshot.data == 24 && workPermitStatus == 'Pending'
                    ? 'Pending @vTime Hrs Verification'.trParams(
                        {'vTime': (workPermitVerificationTime ?? 0).toString()})
                    : workPermitStatus.tr,
                style: const TextStyle(color: AppColors.white, fontSize: 14),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          }
          return const Text("Await for data");
        },
      );

  Future<void> _showWorkPermitModal() async {
    await Get.dialog(WorkPermitModal(
      token: candidateData!['token'],
      onSave: (enteredText) {},
      userId: candidateData!['user_id'],
    ));
    if (!mounted) return;
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    candidateBloc.resetWorkPermit();
  }

  Color getWorkPermitColor() {
    switch (workPermitStatus) {
      case 'Pending':
        return AppColors.primaryColor;
      case 'Verified':
        return AppColors.green;
      default:
        return AppColors.red;
    }
  }
}
