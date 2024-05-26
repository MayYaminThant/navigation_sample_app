part of '../../views.dart';

class SaveBigDataModal extends StatefulWidget {
  const SaveBigDataModal(
      {super.key, required this.controller, required this.status});

  final ScrollController controller;
  final String status;

  @override
  State<SaveBigDataModal> createState() => _SaveBigDataModalState();
}

class _SaveBigDataModalState extends State<SaveBigDataModal>
    with SingleTickerProviderStateMixin {
  int agentFee = 0;
  Map? candidateData;
  String countryName = '';
  String currency = '';
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController expectedSalaryController =
      TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String gender = '';
  bool isShowOnlyEntries = false;
  bool isWorkRestDays = false;
  List<String> languageSkillList = [];
  String myNationalityCountryName = 'Unknown';
  String nationality = '';
  String religion = '';
  String residingCountry = '';
  int restDay = 0;
  List<String> skillList = [];
  final TextEditingController startDateController = TextEditingController();
  int selectAge = 0;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.candidateTableName);
    setState(() {
      countryName = box.get(DBUtils.country) ?? '';
    });
    if (data != null) {
      User user = UserModel.fromJson(data);
      if (user.candidate != null) {
        _addEmployeeSkills(user.candidate!);
      }
      superPrint(skillList.length);
      setState(() {
        candidateData = data;
        myNationalityCountryName = candidateData!['nationality'] ?? 'Unknown';
        religion = candidateData!['religion'] ?? '';
        restDay = user.candidate!.restDayChoice ?? -1;
        isWorkRestDays = user.candidate!.restDayWorkPref ?? false;
      });
      //My Age
      if (candidateData != null) {
        if (candidateData![DBUtils.candidateTableName]['date_of_birth'] !=
            null) {
          DateTime value = DateTime.parse(
              candidateData![DBUtils.candidateTableName]['date_of_birth']);
          ageController.text = int.parse(
                  (DateTime.now().difference(value).inDays / 365)
                      .toStringAsFixed(0))
              .toString();
        }
      }
    }
  }

  void _addEmployeeSkills(Candidate candidate) {
    if (candidate.skillGeneralHousework != null &&
        candidate.skillGeneralHousework!) {
      skillList.add('General Housework');
    }
    if (candidate.skillInfantCare != null && candidate.skillInfantCare!) {
      skillList.add('Infant Care');
    }
    if (candidate.skillElderlyCare != null && candidate.skillElderlyCare!) {
      skillList.add('Elderly Care');
    }
    if (candidate.skillPetCare != null && candidate.skillPetCare!) {
      skillList.add('Pet Care');
    }
    if (candidate.skillCooking != null && candidate.skillCooking!) {
      skillList.add('Cooking');
    }
    if (candidate.skillSpecialNeedsCare != null &&
        candidate.skillSpecialNeedsCare!) {
      skillList.add('Special Needs Care');
    }
    if (candidate.skillbedriddenCare != null && candidate.skillbedriddenCare!) {
      skillList.add('Bedidden Care');
    }
    if (candidate.skillHandicapCare != null && candidate.skillHandicapCare!) {
      skillList.add('Handicap Care');
    }
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
        physics:const BouncingScrollPhysics(),
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
              _getSearchDescription,
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
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  2: FlexColumnWidth(2)
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: _getMyAgeDropDown),
                  _getSpacerTableRow,
                  TableRow(children: _getReligionDropDown),
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
              _getSearchNowButton
            ],
          ),
        ),
      ),
    );
  }

  //Search Header
  Widget get _getSearchHeader {
    return Text(
      StringConst.homeSearchTitle.tr,
      style: const TextStyle(
          color: AppColors.black, fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  //Offer Description
  Widget get _getSearchDescription {
    return Text(
      StringConst.offerSubDescriptionText.tr,
      style: const TextStyle(
          color: AppColors.black, fontSize: 14, fontWeight: FontWeight.w300),
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

        TableRow(children: _getMyNationalityCountryDropDown),
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
      Text(
        StringConst.countryOfWorkText.tr,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),
      CountryDropdownItem(
        initialValue: countryName,
        topCountries: kEmployerTopCountries,
        title: StringConst.countryText,
        onValueChanged: (String value) {
          setState(() {
            countryName = value;
          });
        },
        textColor: AppColors.black,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
        prefix: ConfigsKeyHelper.offerWorkCountryKey,
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
              style: const TextStyle(color: AppColors.black, fontSize: 16),
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
              ))
        ],
      ),
      Row(
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
            style: const TextStyle(color: AppColors.black, fontSize: 14),
          ),
        ],
      )
    ];
  }

  List<Widget> get _getExpectedSalaryDropDown {
    return [
      Text(
        StringConst.myExpectedMonthlySalaryText.tr,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          countryName == '' ?
          CurrencyField(
            key: const Key('modalCurrencyFieldEmptyCountryName'),
            controller: expectedSalaryController,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            textColor: AppColors.black,
            initialValue: '',
            onValueChanged: (String value) {
              setState(() {
                currency = value;
              });
            },
            prefix: ConfigsKeyHelper.offerCurrencyCodeKey,
          ) :
          CurrencyField(
            key: const Key('modalCurrencyFieldSetCountryName'),
            controller: expectedSalaryController,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            textColor: AppColors.black,
            initialValue: countryName,
            onValueChanged: (String value) {
              setState(() {
                currency = value;
              });
            },
            prefix: ConfigsKeyHelper.offerCurrencyCodeKey,
          ),
          NormalRangeText(selectedCurrencyCode: currency, selectedCountryOfWork: countryName,)
        ],
      )
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  // List<Widget> get _getAgentFeesDropDown {
  //   return [
  //     Row(
  //       children: [
  //         const Text(
  //           StringConst.agentFeeText,
  //           style: TextStyle(color: AppColors.black, fontSize: 16),
  //         ),
  //         const SizedBox(
  //           width: 10,
  //         ),
  //         SizedBox(
  //           height: 24,
  //           width: 24,
  //           child: Image.asset(
  //             'assets/icons/messagequestion.png',
  //             color: AppColors.black,
  //           ),
  //         )
  //       ],
  //     ),
  //     DropdownItem(
  //       datas: kAgentFeesList,
  //       initialValue: 'Select Month',
  //       backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
  //       title: StringConst.monthText,
  //       onValueChanged: (String value) {
  //         setState(() {
  //           agentFee =
  //               int.parse(value.replaceAll(' Month', '').replaceAll('s', ''));
  //         });
  //       },
  //       suffixIcon: Iconsax.arrow_down5,
  //     )
  //   ];
  // }

  List<Widget> get _getStartDateDropDown {
    return [
      Text(
        StringConst.startDateText.tr,
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
    ];
  }

  List<Widget> get _getEndDateDropDown {
    return [
      Text(
        StringConst.endDateText.tr,
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

  TableRow get _getSpacerTableRow => const TableRow(children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        )
      ]);

  //Search Now Button
  Widget get _getSearchNowButton {
    return Padding(
      padding: const EdgeInsets.all(Sizes.padding20),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: Sizes.button47,
          child: CustomPrimaryButton(
            text: StringConst.saveText,
            onPressed: () => _createEmployerSearch(),
          )),
    );
  }

  //Employer Search
  _createEmployerSearch() {
    superPrint("HERE");
    superPrint(currency);
    final CandidateBloc candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateCreateBigDataRequestParams params =
        CandidateCreateBigDataRequestParams(
            token: candidateData!['token'],
            countryOfWork: countryName,
            currency: currency,
            agentFee: agentFee,
            availableEndDate: endDateController.text,
            availableStartDate: startDateController.text,
            salary: expectedSalaryController.text.isNotEmpty
                ? int.parse(expectedSalaryController.text)
                : null,
            skillGeneralHousework: skillList.contains('Infant Care') ? 1 : 0,
            skillInfantCare: skillList.contains('Infant Care') ? 1 : 0,
            skillElderlyCare: skillList.contains('Elderly Care') ? 1 : 0,
            skillPetCare: skillList.contains('Pet Care') ? 1 : 0,
            skillCooking: skillList.contains('Cooking') ? 1 : 0,
            skillSpecialNeedsCare:
                skillList.contains('Special Needs Care') ? 1 : 0,
            skillBedriddenCare: skillList.contains('Bedidden Care') ? 1 : 0,
            skillHandicapCare: skillList.contains('Handicap Care') ? 1 : 0,
            // countryOfResidence:
            //     candidateData![DBUtils.candidateTableName] != null
            //         ? candidateData![DBUtils.candidateTableName]
            //             ['country_of_residence']
            //         : null,
            age: ageController.text.isNotEmpty
                ? int.parse(ageController.text)
                : null,
            religion: religion,
            restDayChoice: restDay,
            restDayWorkPref: isWorkRestDays ? 1 : 0,
            availabilityStatus: widget.status);
    candidateBloc.add(CandidateCreateBigDataRequested(params: params));
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
              style: const TextStyle(color: AppColors.black, fontSize: 15)),
        ),
      ],
    );
  }

  //My Age
  List<Widget> get _getMyAgeDropDown {
    return [
      Text(
        StringConst.myAge,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),
      _getTextField(ageController, StringConst.myAge, false, 1, false,
          inputType: TextInputType.number)
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

  //Show Only Entries with Picture
  Widget get _getShowOnlyEntries {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckBox(
          onValueChanged: (bool value) => setState(() {
            isShowOnlyEntries = value;
          }),
          trailing: Text(StringConst.showOnlyEntriesWithPicturesText.tr,
              style: const TextStyle(color: AppColors.black, fontSize: 15)),
        ),
      ],
    );
  }

  //Rest Days
  List<Widget> get _getRestDaysDropDown {
    return [
      Text(
        StringConst.restDaysText.tr,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),
      RestDayDropdownItem(
          initialValue: '$restDay',
          title: StringConst.selectRestDaysText,
          onValueChanged: (RestDay data) => setState(() {
                restDay = data.value ?? -1;
              }),
          backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
          suffixIcon: Iconsax.arrow_down5,
          prefix: ConfigsKeyHelper.offerRestDayKey,
          textColor: AppColors.black)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus == null
            ? null
            : FocusManager.instance.primaryFocus!.unfocus(),
        child: _getAdvancedSearchContainer);
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
}
