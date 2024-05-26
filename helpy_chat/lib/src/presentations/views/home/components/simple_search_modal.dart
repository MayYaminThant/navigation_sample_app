import 'dart:convert';

import 'package:dh_mobile/src/core/utils/configs_key_helper.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/views/home/components/normal_range_text.dart';
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
import '../../employeer/components/employer_flag.dart';
import '../../register/components/value_error_popup.dart';
import 'currency_field.dart';

class SimpleSearchModal extends StatefulWidget {
  const SimpleSearchModal({super.key});

  @override
  State<SimpleSearchModal> createState() => _SimpleSearchModalState();
}

class _SimpleSearchModalState extends State<SimpleSearchModal> {
  Map? candidateData;
  String countryOfWork = '';
  String appLocale = '';
  String myNationalityCountryName = 'Unknown';
  int agentFee = 0;
  String selectedCurrencyCode = 'SGD';
  final TextEditingController expectedSalaryController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.candidateTableName);
    if (data != null) {
      setState(() {
        candidateData = data;
        myNationalityCountryName = candidateData!['nationality'] ?? 'Unknown';
      });
    }
    setState(() {
      appLocale = box.get(DBUtils.country) ?? '';
      countryOfWork = appLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getSearchContainer;
  }

  //Simple Search Container
  Widget get _getSearchContainer => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GestureDetector(
          onTap: () {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
            }
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _getSearchTable,
                _getAdvanceSearch,
                _getSearchNowButton,
              ],
            ),
          ),
        ),
      );

  Widget get _getSearchTable {
    return Table(
      columnWidths: {
        0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.4),
        2: const FlexColumnWidth(2)
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
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
        TableRow(children: _getMyNationalityCountryDropDown),
        const TableRow(children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          )
        ]),
        TableRow(children: _getExpectedSalaryDropDown),
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
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          StringConst.countryOfWorkText.tr,
          style: const TextStyle(color: AppColors.black, fontSize: 16),
        ),
      ),
      CountryDropdownItem(
        initialValue: countryOfWork,
        topCountries: kEmployerTopCountries,
        title: StringConst.countryText,
        onValueChanged: (String value) {
          setState(() {
            countryOfWork = value;
          });
        },
        prefix: ConfigsKeyHelper.simpleSearchWorkCountryKey,
        textColor: AppColors.black,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
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
                  message: StringConst.myNationalityInfoText.tr,
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
              : const SizedBox(width: 20),
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
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          StringConst.myExpectedMonthlySalaryText.tr,
          style: const TextStyle(color: AppColors.black, fontSize: 16),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrencyField(
              controller: expectedSalaryController,
              initialValue: appLocale.isEmpty || appLocale == "Others"
                  ? "Singapore"
                  : appLocale,
              textColor: AppColors.black,
              backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
              onValueChanged: (String value) {
                setState(() {
                  selectedCurrencyCode = value;
                });
              },
              prefix: ConfigsKeyHelper.simpleSearchCurrencyCodeKey),
          NormalRangeText(selectedCurrencyCode: selectedCurrencyCode, selectedCountryOfWork: countryOfWork,)
        ],
      )
    ];
  }

  List<Widget> get _getStartDateDropDown {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 10, top: 10),
        child: Text(
          StringConst.startDateText.tr,
          style: const TextStyle(color: AppColors.black, fontSize: 16),
        ),
      ),

      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomDatePicker(
            controller: startDateController,
            enabled: true,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
            isInitialDate: true,
            isShowPreviousDate: false,
            textColor: AppColors.black,
          ))
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  //Advanced Search
  Widget get _getAdvanceSearch => GestureDetector(
        onTap: () {
          SavedSearch savedSearch = SavedSearch(
              country: countryOfWork,
              currency: selectedCurrencyCode,
              expectedSalary: expectedSalaryController.text.isNotEmpty
                  ? int.parse(expectedSalaryController.text)
                  : null,
              startDate: startDateController.text);
          Navigator.of(context).pop();
          Get.toNamed(advancedSearchPageRoute,
              parameters: {'data': json.encode(savedSearch)});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.cardColor.withOpacity(0.1),
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

  //Employer Search
  _createEmployerSearch() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerSearchCreateRequestParams params =
        EmployerSearchCreateRequestParams(
      token: candidateData != null ? candidateData!['token'] : null,
      country: countryOfWork,
      // agentFee: agentFee,
      currency: selectedCurrencyCode,
      expectedSalary: expectedSalaryController.text.isNotEmpty
          ? int.parse(expectedSalaryController.text.toString())
          : 0,
      startDate: startDateController.text,
      endDate: startDateController.text,
    );
    //superPrint('params ${currency}');
    employerBloc.add(EmployerSearchCreateRequested(params: params));
  }
}
