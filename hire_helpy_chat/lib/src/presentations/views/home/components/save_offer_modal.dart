part of '../../views.dart';

class SaveOfferModal extends StatefulWidget {
  const SaveOfferModal(
      {super.key, required this.controller, required this.status});
  final ScrollController controller;
  final String status;

  @override
  State<SaveOfferModal> createState() => _SaveOfferModalState();
}

class _SaveOfferModalState extends State<SaveOfferModal>
    with SingleTickerProviderStateMixin {
  Map? candidateData;
  String countryName = '';
  String dhNationalityCountryName = '';
  int agentFee = 0;
  String currency = '';
  final TextEditingController expectedSalaryController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  List<String> skillList = [];
  String gender = '';
  String residingCountry = '';
  List<String> languageSkillList = [];
  int? restDayChoice = 0;
  bool isWorkRestDays = false;
  bool isShowOnlyEntries = false;
  String religion = '';

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.employerTableName);
    setState(() {
      countryName = box.get(DBUtils.country) ?? '';
    });
    if (data != null) {
      setState(() {
        candidateData = data;
        religion = candidateData!['religion'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: _getAdvancedSearchContainer);
  }

  Widget get _getAdvancedSearchContainer {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      ),
      child: SingleChildScrollView(
        controller: widget.controller,
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
                textColor: AppColors.black,
                onValueChanged: (List<String> value) => setState(() {
                  skillList = value;
                }),
                prefix: ConfigsKeyHelper.offerTaskTypeKey,
              ),
              const SizedBox(
                height: 20,
              ),
              Table(
                children: [
                  TableRow(children: _getReligionDropDown),
                  _getSpacerTableRow,
                  TableRow(children: _getRestDaysDropDown),
                  _getSpacerTableRow,
                ],
              ),
              _getIsWorkRestDays,
              const SizedBox(
                height: 10,
              ),
              //_getShowOnlyEntries,
              _getSearchNowButton
            ],
          ),
        ),
      ),
    );
  }

  //Search Header
  Widget get _getSearchHeader {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConst.homeSearchTitle,
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        Text(
          "Your Job Offer Will Be Visible to Domestic Helpers".tr,
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w100),
        ),
      ],
    );
  }

  Widget get _getSearchTable {
    return Table(
      columnWidths: {
        0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.45),
        2: const FlexColumnWidth(2)
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: _getCountryDropDown),
        _getSpacerTableRow,
        TableRow(children: _getDHNationalityCountryDropDown),
        _getSpacerTableRow,
        TableRow(children: _getExpectedSalaryDropDown),
        // _getSpacerTableRow,
        // TableRow(children: _getAgentFeesDropDown),
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
              style: const TextStyle(color: AppColors.black, fontSize: 16),
            ),
          ),
          GestureDetector(
              onTap: () => showInfoModal(
                  title: StringConst.countryOfWorkText.tr,
                  message: StringConst.offerCountryInfoText,
                  type: 'info'),
              child: const Icon(
                Iconsax.message_question,
                color: AppColors.black,
              ))
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EmployerFlag(
            country: countryName,
            configKey: ConfigsKeyHelper.firstTimeLoadCountryKey,
          ),
          Text(
            countryName,
            style: const TextStyle(color: AppColors.black, fontSize: 14),
          ),
        ],
      )
    ];
  }

  List<Widget> get _getDHNationalityCountryDropDown {
    return [
      Text(
        StringConst.domesticHelperNationalityText,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),
      CountryDropdownItem(
        initialValue: dhNationalityCountryName,
        topCountries: kEmployerTopCountries,
        title: StringConst.domesticHelperNationalityText,
        onValueChanged: (String value) {
          setState(() {
            dhNationalityCountryName = value;
          });
        },
        prefix: ConfigsKeyHelper.offerDHNationalityKey,
        textColor: AppColors.black,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
      )
    ];
  }

  List<Widget> get _getExpectedSalaryDropDown {
    return [
      Text(
        StringConst.offeredMonthlySalaryText.tr,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrencyField(
            controller: expectedSalaryController,
            initialValue: countryName,
            onValueChanged: (String value) {
              setState(() {
                currency = value;
              });
            },
            prefix: ConfigsKeyHelper.adSearchCurrencyCodeKey,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            textColor: AppColors.black,
          ),
          NormalRangeText(selectedCurrencyCode: currency, selectedCountryOfWork: countryName)
        ],
      )
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  List<Widget> get _getStartDateDropDown {
    return [
      Text(
        StringConst.startDateText,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),

      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomDatePicker(
            controller: startDateController,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            enabled: true,
            isInitialDate: true,
            isShowPreviousDate: false,
          ))
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  List<Widget> get _getEndDateDropDown {
    return [
      Text(
        StringConst.endDateText,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomDatePicker(
            controller: endDateController,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            enabled: true,
            isInitialDate: false,
            isShowPreviousDate: false,
          ))
    ];
  }

  //Religion Dropdown
  List<Widget> get _getReligionDropDown {
    return [
      Text(
        StringConst.myReligion,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),
      ReligionDropdownItem(
        initialValue: religion,
        title: '',
        onValueChanged: (String data) {
          setState(() {
            religion = data;
          });
        },
        backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
        textColor: AppColors.black,
        iconPadding: 0,
        prefix: ConfigsKeyHelper.adSearchReligionKey,
      )
    ];
  }

  //Rest Days
  List<Widget> get _getRestDaysDropDown {
    return [
      Text(
        StringConst.restDaysText,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),

      RestDayDropdownItem(
        initialValue: '',
        title: StringConst.selectRestDaysText,
        onValueChanged: (RestDay data) => setState(() {
          print('data');
          restDayChoice = data.value ?? -1;
        }),
        backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
        suffixIcon: Iconsax.arrow_down5,
        prefix: ConfigsKeyHelper.offerRestDayKey,
        textColor: AppColors.black,
      )
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
            color: AppColors.cardColor.withOpacity(0.2)),
        maxLine: maxLine ?? 1,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
        controller: controller,
        textInputType: TextInputType.text,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
        hasPrefixIcon: false,
        hasTitle: true,
        isRequired: true,
        hasSuffixIcon: hasSuffixIcon,
        titleStyle: const TextStyle(
          color: AppColors.black,
          fontSize: Sizes.textSize14,
        ),
        hasTitleIcon: false,
        enabledBorder: Borders.noBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(color: AppColors.black),
        ),
        hintTextStyle:
            const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
        textStyle: const TextStyle(color: AppColors.primaryGrey),
        hintText: title,
      ),
    );
  }

  //Work Rest Days
  Widget get _getIsWorkRestDays {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckBox(
          checkBoxColor: AppColors.primaryGrey.withOpacity(0.5),
          onValueChanged: (bool value) => setState(() {
            isWorkRestDays = value;
          }),
          trailing: Text('Need Helper To Work On Rest Days'.tr,
              style: const TextStyle(color: AppColors.black, fontSize: 15)),
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
          checkBoxColor: AppColors.primaryGrey.withOpacity(0.5),
          onValueChanged: (bool value) => setState(() {
            isShowOnlyEntries = value;
          }),
          trailing: Text(StringConst.showOnlyEntriesWithPicturesText,
              style: const TextStyle(color: AppColors.black, fontSize: 15)),
        ),
      ],
    );
  }

  //Search Now Button
  Widget get _getSearchNowButton {
    return Padding(
      padding: const EdgeInsets.all(Sizes.padding20),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: Sizes.button47,
          child: CustomPrimaryButton(
            text: StringConst.updateMyOfferText,
            onPressed: () => _createEmployerSearch(),
          )),
    );
  }

  //Employer Search
  _createEmployerSearch() {
    final EmployerBloc employerBloc = BlocProvider.of<EmployerBloc>(context);

    EmployerCreateOfferRequestParams params = EmployerCreateOfferRequestParams(
        token: candidateData!['token'],
        availableEndDate: endDateController.text,
        availableStartDate: startDateController.text,
        salary: expectedSalaryController.text.isNotEmpty
            ? int.parse(expectedSalaryController.text)
            : null,
        currency: currency,
        skillGeneralHousework: skillList.contains('Infant Care') ? 1 : 0,
        skillInfantCare: skillList.contains('Infant Care') ? 1 : 0,
        skillElderlyCare: skillList.contains('Elderly Care') ? 1 : 0,
        skillPetCare: skillList.contains('Pet Care') ? 1 : 0,
        skillCooking: skillList.contains('Cooking') ? 1 : 0,
        skillSpecialNeedsCare: skillList.contains('Special Needs Care') ? 1 : 0,
        skillBedriddenCare: skillList.contains('Bedidden Care') ? 1 : 0,
        skillHandicapCare: skillList.contains('Handicap Care') ? 1 : 0,
        //processFee: agentFee,
        religion: religion,
        restDayChoice: restDayChoice,
        countryOfWorkOffer: countryName,
        dhNationality: dhNationalityCountryName,
        restDayWorkPref: isWorkRestDays ? 1 : 0,
        availabilityStatus: widget.status);

    employerBloc.add(EmployerCreateOfferRequested(params: params));
  }
}
