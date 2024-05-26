part of '../../views.dart';

class FamilyInformationSection extends StatefulWidget {
  const FamilyInformationSection({super.key});

  @override
  State<FamilyInformationSection> createState() =>
      _FamilyInformationSectionState();
}

class _FamilyInformationSectionState extends State<FamilyInformationSection> {
  final TextEditingController numberOfSiblingsController =
      TextEditingController();
  final TextEditingController ageController = TextEditingController();

  List<dynamic> membersData = [];
  Map? candidateData;
  Candidate? candidate;
  String? familyStatus;
  String route = '';
  bool clickedExit = false;
  String memberType = '';
  int selectAge = 0;

  @override
  void initState() {
    _getCandidateData();
    _initializeData();
    super.initState();
  }

  void _initializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
    if (candidateData![DBUtils.candidateTableName] != null) {
      _requestCandidateProfile();
    }
  }

  void _requestCandidateProfile() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateRequestParams params = CandidateRequestParams(
        token: candidateData!['token'], userId: candidateData!['user_id']);
    candidateBloc.add(CandidateProfileRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return BackgroundScaffold(
          availableBack: true, scaffold: _getFamilyInformationScaffold);
    }, listener: (_, state) {
      if (state is CandidateProfileSuccess) {
        if (state.data.data != null) {
          Candidate data = CandidateModel.fromJson(state.data.data!['data']);
          if (candidate == null) {
            setState(() {
              candidate = data;
              _initializeCandidateData();
            });
          }
        }
      }

      if (state is CandidateProfileFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateUpdateFamilyInformationSuccess) {
        if (state.data.data != null) {
          state.data.data!['data']['token'] = candidateData!['token'];
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);
          clickedExit
              ? Get.offAllNamed(rootRoute)
              : Get.toNamed(skillAndQualificationPageRoute);
        }
      }

      if (state is CandidateUpdateFamilyInformationFail) {
        setState(() {
          clickedExit = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getFamilyInformationScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: _getFamilyInformationContainer,
      bottomNavigationBar: BottomNavigationItem(
          onNextButtonPressed: () => _checkValidation(),
          onSaveAndQuitButtonPressed: () {
            setState(() {
              clickedExit = true;
            });
            _addFamilyInformation();
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
          StringConst.familyInformationTitle.tr,
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

  Widget get _getFamilyInformationContainer => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const ProfileStepper(
                currentIndex: 1,
              ),
              _getFamilyInformationItems,
              const SizedBox(
                height: 20,
              ),
              _getAddChildrenContainer,
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );

  Widget get _getFamilyInformationItems => Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _getSpacingTableRow,
          TableRow(
            children: _getMartialDropDown,
          ),
          TableRow(children: _getNumberOfSiblings)
        ],
      );

  //Gender Dropdown
  List<Widget> get _getMartialDropDown {
    return [
      Text(
        StringConst.martialStatusText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      DropdownItem(
          initialValue: familyStatus != null ? familyStatus.toString() : '',
          title: StringConst.martialStatusText,
          onValueChanged: (String value) {
            setState(() {
              familyStatus = value;
            });
          },
          datas: const [],
          suffixIcon: Iconsax.arrow_down5,
          prefix: ConfigsKeyHelper.maritalStatusKey)
    ];
  }

  //Number of Siblings
  List<Widget> get _getNumberOfSiblings => [
        Text(
          StringConst.numberOfSiblingsText.tr,
          style: const TextStyle(color: AppColors.white, fontSize: 16),
        ),
        _getTextField(numberOfSiblingsController, 'Number', false, 1,
            TextInputType.number)
      ];

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
    TextInputType inputType,
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
        hintTextStyle:
            const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
        textStyle: const TextStyle(color: AppColors.primaryGrey),
        hintText: title,
      ),
    );
  }

  //Add Family Member
  Widget get _getAddChildrenContainer => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConst.familyMemberText.tr,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: AppColors.backgroundGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringConst.addFamilyMembersText.tr,
                  style: const TextStyle(
                      color: AppColors.primaryGrey, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                _getMemberList,
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    1: FixedColumnWidth(120.0),
                    2: FixedColumnWidth(67.0),
                  },
                  children: [
                    TableRow(
                      children: [
                        MemberTypesDropdownItem(
                          prefix: ConfigsKeyHelper.familyMemberTypeKey,
                          title: StringConst.familyMemberText,
                          onValueChanged: (String value) {
                            setState(() {
                              memberType = value;
                            });
                          },
                          initialValue: memberType,
                          iconPadding: 0,
                          topCountries: const [],
                          backgroundColor: AppColors.white,
                          textColor: AppColors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CustomYearPicker(
                            initialValue: selectAge,
                            onValueChanged: (value) {
                              setState(() {
                                selectAge = value;
                              });
                            },
                            title: 'Year of Birth',
                            backgroundColor: AppColors.white,
                            textColor: AppColors.black,
                            showOnlyAge: false,
                          ),
                        ),
                        GestureDetector(
                          onTap: memberType.isEmpty || selectAge == 0
                              ? null
                              : () => _addChildern(),
                          child: Container(
                            width: 42,
                            height: 47,
                            decoration: BoxDecoration(
                                color: memberType.isEmpty || selectAge == 0
                                    ? AppColors.secondaryGrey
                                    : AppColors.green,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Center(
                                child: Icon(
                              Iconsax.add_circle,
                              color: AppColors.white,
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      );

  Widget get _getMemberList {
    if (membersData.isNotEmpty) {
      return Wrap(
        children: membersData
            .map((e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${e['type'].toString()} : ${int.parse((DateTime.now().difference(DateTime(e['age_year'])).inDays / 365).toStringAsFixed(0))}',
                      style:
                          const TextStyle(color: AppColors.white, fontSize: 16),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            membersData.removeWhere((element) => element == e);
                          }),
                          child: Container(
                              margin: const EdgeInsets.all(10.0),
                              width: 25,
                              height: 25,
                              child: const Icon(
                                Iconsax.trash,
                                size: 20,
                                color: AppColors.red,
                              )),
                        )
                      ],
                    )
                  ],
                ))
            .toList(),
      );
    } else {
      return Container();
    }
  }

  void _addChildern() {
    if (selectAge == 0) {
      showErrorSnackBar('Please select age.');
    } else if (memberType.isEmpty) {
      showErrorSnackBar('Please select member type.');
    } else {
      setState(() {
        membersData.add({"type": memberType, "age_year": selectAge});
        selectAge = 0;
        memberType == '';
      });
    }
  }

  void _addFamilyInformation() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateUpdateFamilyStatusRequestParams params =
        CandidateUpdateFamilyStatusRequestParams(
            token: candidateData!['token'],
            userId: candidateData!['user_id'],
            familyStatus: familyStatus,
            numOfSiblings: numberOfSiblingsController.text.isNotEmpty
                ? int.parse(numberOfSiblingsController.text.toString())
                : null,
            members: membersData.isNotEmpty ? membersData : null,
            updateProgress: _getUpdateProgress());
    candidateBloc
        .add(CandidateUpdateFamilyInformationRequested(params: params));
  }

  void _initializeCandidateData() {
    familyStatus = candidate!.familyStatus ?? '';
    numberOfSiblingsController.text = candidate!.numOfSiblings != null
        ? candidate!.numOfSiblings.toString()
        : '';
    if (candidate!.familyMembers != null) {
      for (int i = 0; i < candidate!.familyMembers!.length; i++) {
        membersData.add({
          "type": candidate!.familyMembers![i]['member_type'],
          "age_year": candidate!.familyMembers![i]['pivot']['member_dob_year']
        });
      }
    }
  }

  void _checkValidation() {
    List<String> requiredControllers = [
      familyStatus != null ? familyStatus.toString() : '',
    ];

    List<String> requiredMessages = const [
      StringConst.martialStatusText,
    ];

    if (familyStatus == null || familyStatus.toString() == '') {
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
                    nextRoute: skillAndQualificationPageRoute,
                    currentRoute: familyInformationPageRoute,
                  ),
                ),
              ));
    } else {
      _addFamilyInformation();
    }
  }

  double getPopupHeight(List<String> requiredControllers) {
    double height = 210.0;
    for (int i = 0; i < requiredControllers.length; i++) {
      if (requiredControllers[i] == '' || requiredControllers[i] == '0') {
        height += 30;
      }
    }
    return height;
  }

  int _getUpdateProgress() {
    if (candidate == null) {
      return 1;
    } else if (candidate != null && candidate!.familyStatus == null) {
      return 1;
    } else {
      return 0;
    }
  }
}
