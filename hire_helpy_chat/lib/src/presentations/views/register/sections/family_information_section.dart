part of '../../views.dart';

class FamilyInformationSection extends StatefulWidget {
  const FamilyInformationSection({super.key});

  @override
  State<FamilyInformationSection> createState() =>
      _FamilyInformationSectionState();
}

class _FamilyInformationSectionState extends State<FamilyInformationSection> {
  final TextEditingController specialRequestChildernController =
      TextEditingController();
  final TextEditingController specialRequestElderlyController =
      TextEditingController();
  final TextEditingController specialRequestPetController =
      TextEditingController();

  List<dynamic> membersData = [];
  Map? employerData;
  Employer? employer;
  String? familyStatus;
  String route = '';
  bool clickedExit = false;
  String memberType = '';
  int selectAge = 0;
  bool allFieldsSelected = false;

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

    if (employerData!['employer'] != null) {
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
          scaffold: _getFamilyInformationScaffold);
    }, listener: (_, state) {
      if (state is EmployerProfileSuccess) {
        if (state.data.data != null) {
          Employer data = EmployerModel.fromJson(state.data.data!['data']);
          if (employer == null) {
            setState(() {
              employer = data;
              _initializeEmployerData();
            });
          }
        }
      }

      if (state is EmployerProfileFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerUpdateFamilyInformationSuccess) {
        if (state.data.data != null) {
          state.data.data!['data']['token'] = employerData!['token'];
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);

          clickedExit
              ? Get.offAllNamed(rootRoute)
              : Get.toNamed(languagePageRoute);
        }
      }

      if (state is EmployerUpdateFamilyInformationFail) {
        setState(() {
          clickedExit = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Scaffold get _getFamilyInformationScaffold {
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
          onTap: _backButtonPressed,
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.familyInformationTitle,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const ProfileStepper(
                currentIndex: 1,
              ),
              //_getImageUpload(),

              _getFamilyInformationItems,
              const SizedBox(
                height: 20,
              ),

              _getAddChildrenContainer,

              _getTextField(
                  specialRequestChildernController,
                  "Special requirements for DH when taking care of children.",
                  false,
                  6,
                  TextInputType.text),

              _getTextField(
                  specialRequestElderlyController,
                  "Special requirements for DH when taking care of Elderly.",
                  false,
                  6,
                  TextInputType.text),

              _getTextField(
                  specialRequestPetController,
                  "Special requirements for DH when taking care of Pets.",
                  false,
                  6,
                  TextInputType.text),

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
        ],
      );

  //Gender Dropdown
  List<Widget> get _getMartialDropDown {
    return [
      Text(
        StringConst.familyStatusText,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),

      DropdownItem(
        initialValue: familyStatus != null ? familyStatus.toString() : '',
        title: StringConst.familyStatusText,
        onValueChanged: (String value) {
          setState(() {
            familyStatus = value;
          });
        },
        datas: const [],
        suffixIcon: Iconsax.arrow_down5,
        prefix: ConfigsKeyHelper.maritalStatusKey,
        isRequired: true,
      )
      //DropdownButton(items: {}, onChanged: onChanged)
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

  _getTextField(
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
        hintText: title.tr,
      ),
    );
  }

  //Add Family Member
  Widget get _getAddChildrenContainer => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            StringConst.familyMembersRequiringAttentionText,
            style: TextStyle(color: AppColors.white, fontSize: 16),
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
                const Text(
                  StringConst.addFamilyMembersText,
                  style: TextStyle(color: AppColors.primaryGrey, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                _getMemberList,
                const SizedBox(
                  height: 10,
                ),
                Table(
                  columnWidths: const {
                    1: FixedColumnWidth(120.0),
                    2: FixedColumnWidth(67.0),
                  },
                  children: [
                    TableRow(
                      children: [
                        ///TODO
                        MemberTypesDropdownItem(
                          prefix: ConfigsKeyHelper.familyMemberTypeKey,
                          title: StringConst.familyMemberText,
                          onValueChanged: (String value) {
                            setState(() {
                              memberType = value;
                              allFieldsSelected =
                                  memberType.isNotEmpty && selectAge != 0;
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
                                allFieldsSelected =
                                    memberType.isNotEmpty && selectAge != 0;
                              });
                            },
                            title: 'Year of Birth',
                            backgroundColor: AppColors.white,
                            textColor: AppColors.black,
                            showOnlyAge: false,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            if (allFieldsSelected) {
                              _addChildern();
                            }
                          },
                          child: Container(
                            width: 42,
                            height: 47,
                            decoration: BoxDecoration(
                                color: allFieldsSelected
                                    ? AppColors.green
                                    : AppColors.secondaryGrey,
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
      return ListView.builder(
          itemCount: membersData.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Table(
              columnWidths: const {
                1: FixedColumnWidth(40),
                2: FixedColumnWidth(50),
              },
              children: [
                TableRow(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Text(
                        membersData[index]['type'].toString(),
                        style: const TextStyle(
                            color: AppColors.black, fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Text(
                        int.parse((DateTime.now()
                                        .difference(DateTime(
                                            membersData[index]['age_year']))
                                        .inDays /
                                    365)
                                .toStringAsFixed(0))
                            .toString(),
                        style: const TextStyle(
                            color: AppColors.black, fontSize: 14),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {
                                membersData.removeAt(index);
                              }),
                              child: const SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Icon(
                                    Iconsax.trash,
                                    size: 20,
                                    color: AppColors.red,
                                  )),
                            )
                          ],
                        ))
                  ],
                )
              ],
            );
          });
    } else {
      return Container();
    }
  }

  _backButtonPressed() {
    route != '' ? Get.back() : Get.offNamed(rootRoute);
  }

  _addChildern() {
    if (selectAge == 0) {
      showErrorSnackBar('Please select age.');
    } else if (memberType == '') {
      showErrorSnackBar('Please select member type.');
    } else {
      setState(() {
        membersData.add({"type": memberType, "age_year": selectAge});
        selectAge = 0;
        memberType == '';
        allFieldsSelected = false;
      });
    }
  }

  _addFamilyInformation() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerUpdateFamilyStatusRequestParams params =
        EmployerUpdateFamilyStatusRequestParams(
            token: employerData!['token'],
            familyStatus: familyStatus,
            members: membersData.isNotEmpty ? membersData : [],
            specialRequestChildren: specialRequestChildernController.text,
            specialRequestElderly: specialRequestElderlyController.text,
            specialRequestPet: specialRequestPetController.text,
            updateProgress: _getUpdateProgress());
    employerBloc.add(EmployerUpdateFamilyInformationRequested(params: params));
  }

  void _initializeEmployerData() {
    specialRequestChildernController.text =
        employer!.specialRequestChildern ?? '';
    specialRequestElderlyController.text =
        employer!.specialRequestElderly ?? '';
    specialRequestPetController.text = employer!.specialRequestPet ?? '';
    familyStatus = employer!.familyStatus ?? '';
    if (employer!.familyMembers != null) {
      for (int i = 0; i < employer!.familyMembers!.length; i++) {
        membersData.add({
          "type": employer!.familyMembers![i]['pivot']['member_type'],
          "age_year": employer!.familyMembers![i]['pivot']['member_dob_year']
        });
      }
    }
  }

  _checkValidation() {
    List<String> requiredControllers = [
      familyStatus != null ? familyStatus.toString() : '',
    ];

    List<String> requiredMessages = [
      StringConst.familyStatusText,
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
                      height: getPopupHeight(requiredControllers),
                      width: 300,
                      child: ValueErrorPopup(
                        values: requiredControllers,
                        messages: requiredMessages,
                        nextRoute: languagePageRoute,
                        currentRoute: familyInformationPageRoute,
                      ),
                    );
                  },
                ),
              ));
    } else {
      _addFamilyInformation();
    }
  }

  getPopupHeight(List<String> requiredControllers) {
    double height = 210.0;
    for (int i = 0; i < requiredControllers.length; i++) {
      if (requiredControllers[i] == '' || requiredControllers[i] == '0') {
        height += 30;
      }
    }
    return height;
  }

  _getUpdateProgress() {
    if (employer == null) {
      return 1;
    } else if (employer != null && employer!.familyStatus == null) {
      return 1;
    } else {
      return 0;
    }
  }
}
