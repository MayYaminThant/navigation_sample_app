import 'dart:convert';

import 'package:dh_employer/src/core/utils/configs_key_helper.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:dh_employer/src/presentations/views/candidate/components/employer_flag.dart';
import 'package:dh_employer/src/presentations/views/home/components/normal_range_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/loading.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/widgets.dart';
import '../../register/components/value_error_popup.dart';
import 'currency_field.dart';

class SimpleSearchModal extends StatefulWidget {
  const SimpleSearchModal({super.key});

  @override
  State<SimpleSearchModal> createState() => _SimpleSearchModalState();
}

class _SimpleSearchModalState extends State<SimpleSearchModal> {
  Map? candidateData;
  String appLocale = '';
  String candidateNationalityCountryName = '';
  int agentFee = 0;
  String selectedCurrencyCode = '';
  final TextEditingController offeredSalaryController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.employerTableName);
    setState(() {
      appLocale = box.get(DBUtils.country) ?? '';
    });
    if (data != null) {
      setState(() {
        candidateData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: _getSearchContainer);
  }

  //Simple Search Container
  get _getSearchContainer => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _getSearchTable,
            _getAdvanceSearch,
            _getSearchNowButton,
          ],
        ),
      );

  Widget get _getSearchTable {
    return Table(
      columnWidths: {
        0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.4),
        2: const FlexColumnWidth(2)
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: _getCountryOfWorkDropDown),
        const TableRow(children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          )
        ]),
        TableRow(children: _getCandidateNationalityCountryDropDown),

        const TableRow(children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          )
        ]),
        TableRow(children: _getOfferedSalaryDropDown),
        const TableRow(children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          )
        ]),
        TableRow(children: _getStartDateDropDown),
      ],
    );
  }

  List<Widget> get _getCountryOfWorkDropDown {
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
            style: const TextStyle(color: AppColors.black, fontSize: 14),
          ),
        ],
      )
    ];
  }

  List<Widget> get _getCandidateNationalityCountryDropDown {
    return [
      Text(
        StringConst.domesticHelperNationalityText.tr,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),
      CountryDropdownItem(
        initialValue: candidateNationalityCountryName,
        topCountries: kEmployerTopCountries,
        title: StringConst.domesticHelperNationalityText,
        onValueChanged: (String value) {
          setState(() {
            candidateNationalityCountryName = value;
          });
        },
        prefix: ConfigsKeyHelper.simpleSearchDHNationalityKey,
        textColor: AppColors.black,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
      )
    ];
  }



  List<Widget> get _getOfferedSalaryDropDown {
    return [
      Text(
        StringConst.offeredMonthlySalaryText.tr,
        style: const TextStyle(color: AppColors.black, fontSize: 16),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrencyField(
              controller: offeredSalaryController,
              initialValue: appLocale,
              textColor: AppColors.black,
              backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
              onValueChanged: (String value) {
                setState(() {
                  selectedCurrencyCode = value;
                });
              },
              prefix: ConfigsKeyHelper.simpleSearchCurrencyCodeKey),
          NormalRangeText(selectedCurrencyCode: selectedCurrencyCode, selectedCountryOfWork: appLocale)
        ],
      )
    ];
  }

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
            enabled: true,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            isInitialDate: true,
            isShowPreviousDate: false,
          ))
    ];
  }

  //Advanced Search
  Widget get _getAdvanceSearch => GestureDetector(
        onTap: () {
          SavedSearch savedSearch = SavedSearch(
              country: appLocale,
              currency: selectedCurrencyCode,
              offeredSalary: offeredSalaryController.text.isNotEmpty
                  ? int.parse(offeredSalaryController.text)
                  : null,
              startDate: startDateController.text);
          Get.toNamed(advancedSearchPageRoute,
              parameters: {'data': json.encode(savedSearch)});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.cardColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
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
            child: Text(
              StringConst.advancedSearchText.tr,
              style: const TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
        ),
      );

  //Register Search Button
  Widget get _getSearchNowButton => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            height: Sizes.button47,
            child: CustomPrimaryButton(
              text: StringConst.searchNowText.tr,
              onPressed: () => _checkValidation(),
            )),
      );

  _checkValidation() {
    List<String> requiredControllers = [
      candidateNationalityCountryName != '' ? candidateNationalityCountryName : '',
      offeredSalaryController.text.isNotEmpty
          ? offeredSalaryController.text
          : '',
    ];

    List<String> requiredMessages = [
      StringConst.domesticHelperNationalityText,
      StringConst.offeredMonthlySalaryText.tr
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
                      height: _getPopupHeight(requiredControllers),
                      width: 300,
                      child: ValueErrorPopup(
                          values: requiredControllers,
                          messages: requiredMessages,
                          nextRoute: '',
                          currentRoute: '',
                          isExit: true),
                    );
                  },
                ),
              ));
    }
    else {
      Loading.showLoading(message: StringConst.loadingText);
      _createEmployerSearch();
    }
  }

  //Employer Search
  _createEmployerSearch() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateSearchCreateRequestParams params =
        CandidateSearchCreateRequestParams(
      token: candidateData != null ? candidateData!['token'] : null,
      country: appLocale,
      candidateNationality: candidateNationalityCountryName,
      currency: selectedCurrencyCode,
      offeredSalary: offeredSalaryController.text.isNotEmpty
          ? int.parse(offeredSalaryController.text.toString())
          : 0,
      startDate: startDateController.text,
    );
    candidateBloc.add(CandidateSearchCreateRequested(params: params));
  }

  _getPopupHeight(List<String> requiredControllers) {
    double height = 210.0;
    for (int i = 0; i < requiredControllers.length; i++) {
      if (requiredControllers[i] == '' || requiredControllers[i] == '0') {
        height += 30;
      }
    }
    return height;
  }
}
