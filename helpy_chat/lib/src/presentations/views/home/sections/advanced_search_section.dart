part of '../../views.dart';

class AdvancedSearchSection extends StatefulWidget {
  const AdvancedSearchSection({super.key});

  @override
  State<AdvancedSearchSection> createState() => _AdvancedSearchSectionState();
}

class _AdvancedSearchSectionState extends State<AdvancedSearchSection>
    with SingleTickerProviderStateMixin {
  Map? candidateData;
  String countryOfWork = '';
  String appLocale = '';
  String myNationalityCountryName = 'Unknown';

  late String selectedCurrencyCode;
  final TextEditingController expectedSalaryController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  List<String> skillList = [];
  bool isSaveSearch = false;
  int restDay = -1;
  bool isShowOnlyEntries = false;
  bool isWorkRestDays = false;
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  String religion = '';

  @override
  void initState() {
    _retrieveSearch();
    _initializeAnimation();
    _getCandidateData();
    super.initState();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.candidateTableName);
    setState(() {
      appLocale = box.get(DBUtils.country) ?? '';
      countryOfWork = appLocale;
    });

    if (data != null) {
      User user = UserModel.fromJson(data);
      setState(() {
        candidateData = data;
        myNationalityCountryName = user.nationality ?? 'Unknown';
      });
    }
  }

  void _retrieveSearch() {
    if (Get.parameters.isNotEmpty) {
      final data = SavedSearchModel.fromSavedJson(
          json.decode("${Get.parameters['data']}"));
      _initializeData(data);
    }
  }

  void _initializeData(SavedSearch savedSearch) {
    countryOfWork = savedSearch.country ?? '';
    selectedCurrencyCode = savedSearch.currency ?? "SGD";
    expectedSalaryController.text = savedSearch.expectedSalary != null
        ? savedSearch.expectedSalary.toString()
        : '';
    startDateController.text = savedSearch.startDate ?? '';
    endDateController.text = savedSearch.endDate ?? '';
    endDateController.text = savedSearch.endDate ?? '';
    _addEmployeeSkills(savedSearch);
    restDay = savedSearch.restDayChoice ?? restDay;
    isWorkRestDays = savedSearch.workRestDays ?? isWorkRestDays;
    isShowOnlyEntries =
        savedSearch.showOnlyEntriesWithPics ?? isShowOnlyEntries;
    isSaveSearch = savedSearch.saveMySearch ?? isSaveSearch;
    religion = savedSearch.religion ?? religion;
  }

  void _addEmployeeSkills(SavedSearch savedSearch) {
    if (savedSearch.skillGeneralHousework != null &&
        savedSearch.skillGeneralHousework!) {
      skillList.add('General Housework');
    }
    if (savedSearch.skillInfantCare != null && savedSearch.skillInfantCare!) {
      skillList.add('Infant Care');
    }
    if (savedSearch.skillElderlyCare != null && savedSearch.skillElderlyCare!) {
      skillList.add('Elderly Care');
    }
    if (savedSearch.skillPetCare != null && savedSearch.skillPetCare!) {
      skillList.add('Pet Care');
    }
    if (savedSearch.skillCooking != null && savedSearch.skillCooking!) {
      skillList.add('Cooking');
    }
    if (savedSearch.skillSpecialNeedsCare != null &&
        savedSearch.skillSpecialNeedsCare!) {
      skillList.add('Special Needs Care');
    }
    if (savedSearch.skillbedriddenCare != null &&
        savedSearch.skillbedriddenCare!) {
      skillList.add('Bedidden Care');
    }
    if (savedSearch.skillHandicapCare != null &&
        savedSearch.skillHandicapCare!) {
      skillList.add('Handicap Care');
    }
    if (savedSearch.skillOthersSpecify != null) {
      skillList.add(savedSearch.skillOthersSpecify!);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return BackgroundScaffold(
          availableBack: true, scaffold: _getAdvancedSearchScaffold);
    }, listener: (_, state) {
      if (state is EmployerSearchCreateSuccess) {
        Loading.cancelLoading();
        if (state.employerData.data != null) {
          // showSuccessSnackBar(context, state.data.data!['message']);
          _showRevealSearchesModal(state.employerData.data);
          DBUtils.saveNewData(state.employerData.data, 'search_result');
          if (Get.parameters['data'] != null) _requestSavedSearch();
        }
      }

      if (state is EmployerSearchCreateFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      leadingWidth: 52,
      title: Text(
        StringConst.advancedSearchText.tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w100),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Scaffold get _getAdvancedSearchScaffold => Scaffold(
        bottomNavigationBar: _getSearchNowButton,
        appBar: _getAppBar,
        backgroundColor: Colors.transparent,
        body: _getAdvancedSearchContainer,
      );

  Widget get _getAdvancedSearchContainer {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.padding20, vertical: Sizes.padding20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getSearchHeader,
            const SizedBox(
              height: 20,
            ),
            _getSearchTable,
            EmployeeSkills(
              initialList: skillList,
              onValueChanged: (List<String> value) => setState(() {
                skillList = value;
              }),
              prefix: ConfigsKeyHelper.adSearchTaskTypeKey,
            ),
            const SizedBox(
              height: 20,
            ),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                2: FlexColumnWidth(2)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: _getReligionDropDown),
                _getSpacerTableRow,
                TableRow(children: _getRestDaysDropDown),
                _getSpacerTableRow,
              ],
            ),
            _getIsWorkRestDays,
            const SizedBox(
              height: 20,
            ),
            _getShowOnlyEntries,
            const SizedBox(
              height: 20,
            ),
            if (candidateData != null &&
                candidateData![DBUtils.candidateTableName] != null)
              _getSaveMySearch
          ],
        ),
      ),
    );
  }

  //Search Header
  Widget get _getSearchHeader {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          StringConst.homeSearchTitle.tr,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
            width: Sizes.width24,
            height: Sizes.height24,
            child: Image.asset('assets/icons/search.png'))
      ],
    );
  }

  Widget get _getSearchTable {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.4),
        2: const FlexColumnWidth(2)
      },
      children: [
        TableRow(children: _getCountryDropDown),
        _getSpacerTableRow,
        TableRow(children: _getMyNationalityCountryDropDown),
        _getSpacerTableRow,
        TableRow(children: _getExpectedSalaryDropDown),
        _getSpacerTableRow,
        TableRow(children: _getStartDateDropDown),
        _getSpacerTableRow,
        TableRow(children: _getEndDateDropDown),
      ],
    );
  }

  List<Widget> get _getCountryDropDown {
    return [
      Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            StringConst.countryOfWorkText.tr,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
          )),
      CountryDropdownItem(
        initialValue: countryOfWork,
        topCountries: kEmployerTopCountries,
        title: StringConst.countryText,
        onValueChanged: (String value) {
          setState(() {
            countryOfWork = value;
          });
        },
        prefix: ConfigsKeyHelper.adSearchWorkCountryKey,
      )
    ];
  }

  List<Widget> get _getMyNationalityCountryDropDown {
    return [
      Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              StringConst.myNationalityText.tr,
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
              onTap: () => showInfoModal(
                  title: StringConst.myNationalityText.tr,
                  message: StringConst.myNationalityInfoText,
                  type: 'info'),
              child: const Icon(
                Iconsax.message_question,
                color: AppColors.white,
              ))
        ],
      ),
      Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              myNationalityCountryName != 'Unknown'
                  ? EmployerFlag(
                      country: myNationalityCountryName,
                      configKey: ConfigsKeyHelper.firstTimeLoadCountryKey,
                    )
                  : const SizedBox(
                      width: 20,
                    ),
              Text(
                myNationalityCountryName,
                style: const TextStyle(color: AppColors.white, fontSize: 14),
              ),
            ],
          )),
    ];
  }

  List<Widget> get _getExpectedSalaryDropDown => [
        Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 15.0),
            child: Text(
              StringConst.myExpectedMonthlySalaryText.tr,
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrencyField(
              controller: expectedSalaryController,
              initialValue: selectedCurrencyCode,
              hintText: "Type Here".tr,
              onValueChanged: (String value) {
                setState(() {
                  selectedCurrencyCode = value;
                });
              },
              prefix: ConfigsKeyHelper.adSearchCurrencyCodeKey,
            ),
            NormalRangeText(selectedCurrencyCode: selectedCurrencyCode, selectedCountryOfWork: countryOfWork,)
          ],
        )
      ];

  List<Widget> get _getStartDateDropDown {
    return [
      Container(
        height: 48,
        alignment: Alignment.centerLeft,
        child: Text(
          StringConst.startDateText.tr,
          style: const TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomDatePicker(
            hintText: 'Select Start Date'.tr,
            controller: startDateController,
            enabled: true,
            isInitialDate: true,
            isShowPreviousDate: false,
          ))
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  List<Widget> get _getEndDateDropDown {
    return [
      Container(
        height: 48,
        alignment: Alignment.centerLeft,
        child: Text(
          StringConst.endDateText.tr,
          style: const TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomDatePicker(
            hintText: 'Select End Date'.tr,
            controller: endDateController,
            enabled: true,
            isInitialDate: true,
            isShowPreviousDate: true,
          ))
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  TableRow get _getSpacerTableRow => const TableRow(children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        )
      ]);

  //Religion Dropdown
  List<Widget> get _getReligionDropDown {
    return [
      Text(
        StringConst.employerReligion.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      ReligionDropdownItem(
        initialValue: religion,
        title: 'Select Religion'.tr,
        onValueChanged: (String data) {
          setState(() {
            religion = data;
          });
        },
        iconPadding: 0,
        prefix: ConfigsKeyHelper.adSearchReligionKey,
      )
    ];
  }

  //Rest Days
  List<Widget> get _getRestDaysDropDown {
    return [
      Text(
        StringConst.restDaysText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      RestDayDropdownItem(
          initialValue: restDay.toString(),
          title: StringConst.selectRestDaysText,
          onValueChanged: (RestDay data) => setState(() {
                restDay = data.value ?? -1;
              }),
          suffixIcon: Iconsax.arrow_down5,
          prefix: ConfigsKeyHelper.adSearchRestDayKey)
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  //Work Rest Days
  Widget get _getIsWorkRestDays {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckBox(
          initialValue: isWorkRestDays,
          onValueChanged: (bool value) => setState(() {
            isWorkRestDays = value;
          }),
          trailing: Text(StringConst.iCanworkRestDaysText.tr,
              style:
                  const TextStyle(color: AppColors.primaryGrey, fontSize: 15)),
        ),
      ],
    );
  }

  //Show Only Entries with Picture
  Widget get _getShowOnlyEntries {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckBox(
          isDisabled: true,
          initialValue: isShowOnlyEntries,
          onValueChanged: (bool value) => setState(() {
            isShowOnlyEntries = value;
          }),
          trailing: Text(StringConst.showOnlyEntriesWithPicturesText.tr,
              style: TextStyle(
                  color: AppColors.secondaryGrey.withOpacity(0.6),
                  fontSize: 15)),
        ),
      ],
    );
  }

  Widget get _getSaveMySearch => CustomCheckBox(
        initialValue: isSaveSearch,
        onValueChanged: (bool value) => setState(() {
          isSaveSearch = value;
        }),
        trailing: Text(StringConst.saveMySearchText.tr,
            style: const TextStyle(color: AppColors.primaryGrey, fontSize: 15)),
      );

  //Search Now Button
  Widget get _getSearchNowButton {
    return Padding(
      padding: const EdgeInsets.only(
          left: Sizes.padding20,
          right: Sizes.padding20,
          bottom: Sizes.padding20),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: Sizes.button47,
          child: CustomPrimaryButton(
            text: StringConst.searchNowText,
            onPressed: () => _checkValidation(),
          )),
    );
  }

  //Employer Search
  void _createEmployerSearch() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerSearchCreateRequestParams params =
        EmployerSearchCreateRequestParams(
            token: candidateData != null ? candidateData!['token'] : null,
            userId: candidateData != null ? candidateData!['user_id'] : null,
            country: countryOfWork,
            currency: selectedCurrencyCode,
            expectedSalary: expectedSalaryController.text.isNotEmpty
                ? int.parse(expectedSalaryController.text.toString())
                : 0,
            startDate: startDateController.text,
            endDate: endDateController.text,
            restDayChoice: restDay,
            showOnlyEntriesWithPics: isShowOnlyEntries,
            workRestDays: isWorkRestDays,
            skillGeneralHousework:
                skillList.contains('General Housework') ? 1 : 0,
            skillInfantCare: skillList.contains('Infant Care') ? 1 : 0,
            skillElderlyCare: skillList.contains('Elderly Care') ? 1 : 0,
            skillPetCare: skillList.contains('Pet Care') ? 1 : 0,
            skillCooking: skillList.contains('Cooking') ? 1 : 0,
            skillSpecialNeedsCare:
                skillList.contains('Special Needs Care') ? 1 : 0,
            skillBedriddenCare: skillList.contains('Bedidden Care') ? 1 : 0,
            skillHandicapCare: skillList.contains('Handicap Care') ? 1 : 0,
            saveMySearch: candidateData != null ? isSaveSearch : null,
            religion: religion != '' ? religion : null);

    employerBloc.add(EmployerSearchCreateRequested(params: params));

    Loading.showLoading(message: StringConst.loadingText);
  }

  void _checkValidation() {
    List<String> requiredControllers = [
      countryOfWork != '' ? countryOfWork : '',
      expectedSalaryController.text.isNotEmpty
          ? expectedSalaryController.text
          : '',
    ];

    List<String> requiredMessages = [
      StringConst.countryOfWorkText.tr,
      StringConst.expectedSalaryText
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
    } else {
      Loading.showLoading(message: StringConst.loadingText);
      _createEmployerSearch();
    }
  }

  //Reveal Searches
  void _showRevealSearchesModal(Map<String, dynamic>? data) {
    Future.delayed(const Duration(milliseconds: 100), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _animationController.forward(from: 0.0);

          return SlideTransition(
            position: _animation,
            child:
                RevealSearchPopUp(employerData: data!, isAdvancedSearch: true),
          );
        },
      );
    });
  }

  void _requestSavedSearch() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateSaveSearchRequestParams params = CandidateSaveSearchRequestParams(
        token: candidateData!['token'], userId: candidateData!['user_id']);
    candidateBloc.add(CandidateSaveSearchListRequested(params: params));
  }
}
