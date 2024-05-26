part of '../../views.dart';

class AdvancedSearchSection extends StatefulWidget {
  const AdvancedSearchSection({super.key});

  @override
  State<AdvancedSearchSection> createState() => _AdvancedSearchSectionState();
}

class _AdvancedSearchSectionState extends State<AdvancedSearchSection>
    with SingleTickerProviderStateMixin {
  int agentFee = -1;
  Map? employerData;
  String appLocale = '';
  String selectedCurrencyCode = '';
  String candidateNationalityCountryName = '';
  final TextEditingController endAgeController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController offeredSalaryController = TextEditingController();

  bool isSaveSearch = false;
  bool isShowOnlyEntries = false;
  bool isWorkRestDays = false;
  String religion = '';
  int restDay = -1;
  List<String> skillList = [];
  final TextEditingController startAgeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  late Animation<Offset> _animation;
  late AnimationController _animationController;

  /// holds status if the checkbox for "Only Entries With Picture" is disabled
  bool isShowOnlyEntriesEnabled = false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initializeAnimation();
    _getCandidateData();
    super.initState();
  }

  _initializeAnimation() {
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

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.employerTableName);
    setState(() {
      appLocale = box.get(DBUtils.country) ?? '';
    });
    if (data != null) {
      setState(() {
        employerData = data;
      });
    }

    if (Get.parameters.isNotEmpty) {
      SavedSearch savedSearch = SavedSearchModel.fromSavedJson(
          json.decode(Get.parameters['data'].toString()));
      setState(() {
        _initializeData(savedSearch);
      });
    }
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
        StringConst.advancedSearchText,
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
                TableRow(children: _getDHAgeRangeDropDown),
                _getSpacerTableRow,
                TableRow(children: _getDHReligionDropDown),
                _getSpacerTableRow,
                TableRow(children: _getRestDaysDropDown),
                _getSpacerTableRow
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
            if (employerData != null &&
                employerData![DBUtils.employerTableName] != null)
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
          StringConst.homeSearchTitle,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget get _getSearchTable {
    return Table(
      columnWidths: {
        0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.4),
        2: const FlexColumnWidth(2)
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: _getCountryDropDown),
        _getSpacerTableRow,
        TableRow(children: _getDHNationalityCountryDropDown),
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
      Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              StringConst.countryOfWorkText.tr,
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ),
          GestureDetector(
              onTap: () => showInfoModal(
                  title: StringConst.countryOfWorkText.tr,
                  message: StringConst.offerCountryInfoText,
                  type: 'info'),
              child: const Icon(
                Iconsax.message_question,
                color: AppColors.white,
              ))
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EmployerFlag(
            country: appLocale,
            configKey: ConfigsKeyHelper.firstTimeLoadCountryKey,
          ),
          Text(
            appLocale,
            style: const TextStyle(color: AppColors.white, fontSize: 14),
          ),
        ],
      )
    ];
  }

  List<Widget> get _getDHNationalityCountryDropDown {
    return [
      Text(
        StringConst.domesticHelperNationalityText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      CountryDropdownItem(
        initialValue: "",
        topCountries: kEmployerTopCountries,
        title: "",
        onValueChanged: (String value) {
          setState(() {
            candidateNationalityCountryName = value;
          });
        },
        prefix: ConfigsKeyHelper.adSearchDHNationalityKey,
        textColor: AppColors.white,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
      )
    ];
  }

  List<Widget> get _getExpectedSalaryDropDown {
    return [
      Text(
        StringConst.offeredMonthlySalaryText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrencyField(
            controller: offeredSalaryController,
            initialValue: appLocale,
            hintText: 'Type Here',
            onValueChanged: (String value) {
              setState(() {
                selectedCurrencyCode = value;
              });
            },
            prefix: ConfigsKeyHelper.adSearchCurrencyCodeKey,
          ),
          NormalRangeText(
              selectedCurrencyCode: selectedCurrencyCode,
              selectedCountryOfWork: appLocale)
        ],
      )
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  List<Widget> get _getStartDateDropDown {
    return [
      Text(
        StringConst.startDateText,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),

      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CustomDatePicker(
          controller: startDateController,
          enabled: true,
          isInitialDate: true,
          isShowPreviousDate: false,
          textColor: AppColors.white,
          hintText: 'Select Start Date',
        ),
      )
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  List<Widget> get _getEndDateDropDown {
    return [
      Text(
        StringConst.endDateText,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CustomDatePicker(
          controller: endDateController,
          enabled: true,
          isInitialDate: false,
          isShowPreviousDate: true,
          textColor: AppColors.white,
          hintText: 'Select End Date',
        ),
      )
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

  //DH Age Range
  List<Widget> get _getDHAgeRangeDropDown {
    return [
      Text(
        StringConst.dhAgeRangeText,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      Row(
        children: [
          SizedBox(
            width: 60,
            child: _getTextField(startAgeController, '', false, 1, false,
                inputType: TextInputType.number),
          ),
          Container(
              width: 50,
              margin: const EdgeInsets.only(top: 10.0),
              child: const Center(
                child: Text('To',
                    style: TextStyle(color: AppColors.white, fontSize: 16)),
              )),
          SizedBox(
              width: 60,
              child: _getTextField(endAgeController, '', false, 1, false,
                  inputType: TextInputType.number))
        ],
      ),
    ];
  }

  //DH Religion
  List<Widget> get _getDHReligionDropDown {
    return [
      Text(
        StringConst.dhReligionText,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),

      ReligionDropdownItem(
        initialValue: religion,
        title: StringConst.religionText,
        onValueChanged: (String data) {
          setState(() {
            religion = data;
          });
        },
        iconPadding: 0,
        prefix: ConfigsKeyHelper.adSearchReligionKey,
      )
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  //Rest Days
  List<Widget> get _getRestDaysDropDown {
    return [
      Text(
        StringConst.restDaysText,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),

      RestDayDropdownItem(
        initialValue: restDay.toString(),
        title: StringConst.selectRestDaysText,
        onValueChanged: (RestDay data) => setState(() {
          restDay = data.value ?? -1;
        }),
        suffixIcon: Iconsax.arrow_down5,
        prefix: ConfigsKeyHelper.adSearchRestDayKey,
      )
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  //Work Rest Days
  Widget get _getIsWorkRestDays {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckBox(
          onValueChanged: (bool value) => setState(() {
            isWorkRestDays = value;
          }),
          trailing: Text('Need Helper to Work on Rest Days'.tr,
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
          onValueChanged: (bool value) => setState(() {
            isShowOnlyEntries = value;
          }),
          isDisabled: !isShowOnlyEntriesEnabled,
          trailing: Text(
            StringConst.showOnlyEntriesWithPicturesText,
            style: TextStyle(
              color: !isShowOnlyEntriesEnabled
                  ? AppColors.secondaryGrey.withOpacity(0.6)
                  : AppColors.primaryGrey,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget get _getSaveMySearch => CustomCheckBox(
        initialValue: isSaveSearch,
        onValueChanged: (bool value) => setState(() {
          isSaveSearch = value;
        }),
        trailing: Text(StringConst.saveMySearchText,
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
            onPressed: () => _createCandidateSearch(),
          )),
    );
  }

  //Candidate Search
  _createCandidateSearch() {
    final CandidateBloc candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateSearchCreateRequestParams params =
        CandidateSearchCreateRequestParams(
      token: employerData != null ? employerData!['token'] : null,
      country: appLocale,
      currency: selectedCurrencyCode,
      offeredSalary: offeredSalaryController.text.isNotEmpty
          ? int.parse(offeredSalaryController.text.toString())
          : 0,
      candidateNationality: candidateNationalityCountryName,
      startDate: startDateController.text,
      endDate: endDateController.text,
      skillGeneralHousework: skillList.contains('General Housework') ? 1 : 0,
      skillInfantCare: skillList.contains('Infant Care') ? 1 : 0,
      skillElderlyCare: skillList.contains('Elderly Care') ? 1 : 0,
      skillPetCare: skillList.contains('Pet Care') ? 1 : 0,
      skillCooking: skillList.contains('Cooking') ? 1 : 0,
      skillSpecialNeedsCare: skillList.contains('Special Needs Care') ? 1 : 0,
      skillBedriddenCare: skillList.contains('Bedridden Care') ? 1 : 0,
      skillHandicapCare: skillList.contains('Handicap Care') ? 1 : 0,
      religion: religion,
      ageMin: startAgeController.text.isNotEmpty
          ? int.parse(startAgeController.text)
          : null,
      ageMax: endAgeController.text.isNotEmpty
          ? int.parse(endAgeController.text)
          : null,
      restDaysPerMonthChoice: restDay,
      workRestDays: isWorkRestDays,
      showOnlyEntriesWithPics: isShowOnlyEntries,
      saveMySearch: employerData != null ? isSaveSearch : null,
    );

    candidateBloc.add(CandidateSearchCreateRequested(params: params));

    Loading.showLoading(message: StringConst.loadingText);
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
                RevealSearchPopUp(candidateData: data!, isAdvancedSearch: true),
          );
        },
      );
    });
  }

  void _initializeData(SavedSearch savedSearch) {
    candidateNationalityCountryName = savedSearch.country ?? '';
    // agentFee = savedSearch.agentFee ?? -1;
    offeredSalaryController.text = savedSearch.offeredSalary != null
        ? savedSearch.offeredSalary.toString()
        : '';
    startDateController.text = savedSearch.startDate ?? '';
    endDateController.text = savedSearch.endDate ?? '';
    endDateController.text = savedSearch.endDate ?? '';
    _addEmployeeSkills(savedSearch);
    restDay = savedSearch.restDayChoice ?? 0;
    isWorkRestDays = savedSearch.workRestDays ?? false;
    isShowOnlyEntries = savedSearch.showOnlyEntriesWithPics ?? false;
    isSaveSearch = savedSearch.saveMySearch ?? false;
    startAgeController.text = savedSearch.ageMin ?? '';
    endAgeController.text = savedSearch.ageMax ?? '';
    religion = savedSearch.religion ?? '';
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
      skillList.add('Bedridden Care');
    }
    if (savedSearch.skillHandicapCare != null &&
        savedSearch.skillHandicapCare!) {
      skillList.add('Handicap Care');
    }
    if (savedSearch.skillOthersSpecify != null) {
      skillList.add(savedSearch.skillOthersSpecify!);
    }
  }

  _getTextField(TextEditingController controller, String title,
      bool hasSuffixIcon, int? maxLine, bool isRequired,
      {TextInputType? inputType}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: CustomTextField(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: controller.text.isEmpty && isRequired
                ? Border.all(color: AppColors.red)
                : null,
            color: AppColors.cardColor.withOpacity(0.1)),
        maxLine: maxLine ?? 1,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
        controller: controller,
        textInputType: inputType,
        inputFormatters: [
          if (inputType == TextInputType.number)
            FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3)
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return BackgroundScaffold(
          onWillPop: () => Get.back(), scaffold: _getAdvancedSearchScaffold);
    }, listener: (_, state) {
      if (state is CandidateSearchCreateSuccess) {
        Loading.cancelLoading();
        if (state.candidateData.data != null) {
          // showSuccessSnackBar(state.data.data!['message']);
          _showRevealSearchesModal(state.candidateData.data);
          DBUtils.saveNewData(state.candidateData.data, 'search_result');
          if (Get.parameters['data'] != null) _requestSavedSearch();
        }
      }

      if (state is CandidateSearchCreateFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  _requestSavedSearch() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerSaveSearchRequestParams params = EmployerSaveSearchRequestParams(
        token: employerData!['token'], userId: employerData!['user_id']);
    employerBloc.add(EmployerSaveSearchListRequested(params: params));
  }
}
