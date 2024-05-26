import 'package:dh_employer/src/core/params/params.dart';
import 'package:dh_employer/src/core/utils/snackbar_utils.dart';
import 'package:dh_employer/src/core/utils/string_utils.dart';
import 'package:dh_employer/src/presentations/blocs/blocs.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class NormalRangeText extends StatefulWidget {
  final String selectedCurrencyCode;
  final String selectedCountryOfWork;

  const NormalRangeText(
      {super.key,
      required this.selectedCurrencyCode,
      required this.selectedCountryOfWork});

  @override
  State<NormalRangeText> createState() => _NormalRangeTextState();
}

class _NormalRangeTextState extends State<NormalRangeText> {
  String? normalRangeText;
  String currentCurrencyCode = '';
  String currentCountryOfWork = '';

  @override
  void initState() {
    _recalculateNormalRange();
    currentCountryOfWork = widget.selectedCountryOfWork;
    currentCurrencyCode = widget.selectedCurrencyCode;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NormalRangeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _recalculateNormalRange();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return Text(
        normalRangeText == null
            ? '${'Normal Range'.tr}: ${'Loading...'.tr}'
            : normalRangeText!,
        style: const TextStyle(color: AppColors.primaryGrey, fontSize: 12),
      );
    }, listener: (_, state) {
      if (state is EmployerPHCSalaryRangeExchangeLoading) {
        setState(() {
          normalRangeText = null;
        });
      }

      if (state is EmployerPHCSalaryRangeExchangeSuccess) {
        setState(() {
          normalRangeText =
              '${'Normal Range'.tr}: ${state.convertedSalaryRange.resultCurrency} ${state.convertedSalaryRange.convertedMin} ~ ${state.convertedSalaryRange.convertedMax}';
        });
      }

      if (state is EmployerPHCSalaryRangeExchangeFail) {
        setState(() {
          normalRangeText = null;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  void _recalculateNormalRange() async {
    if (widget.selectedCurrencyCode == currentCurrencyCode &&
        widget.selectedCountryOfWork == currentCountryOfWork) {
      return;
    }
    currentCurrencyCode = widget.selectedCurrencyCode;
    currentCountryOfWork = widget.selectedCountryOfWork;

    if (widget.selectedCountryOfWork == '' ||
        widget.selectedCurrencyCode == '') {
      setState(() {
        normalRangeText = '';
      });
      return;
    }
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    final countriesData =
        (await StringUtils.getExchangeList()) as List<dynamic>;
    final selectedCountryData = countriesData.firstWhere(
        (countryData) =>
            countryData['app_locale'] == widget.selectedCountryOfWork,
        orElse: () => null);
    if (selectedCountryData == null) return;

    final minSalary = double.parse(
        selectedCountryData['candidate_PHC_default_pay_min'].toString());
    final maxSalary = double.parse(
        selectedCountryData['candidate_PHC_default_pay_max'].toString());

    if (widget.selectedCurrencyCode == '') {
      return;
    }
    final params = EmployerPHCSalaryRangeExchangeRequestParams(
        targetCurrency: widget.selectedCurrencyCode,
        phcSalaryMax: maxSalary,
        phcSalaryMin: minSalary);
    employerBloc.add(EmployerPHCSalaryRangeExchangeRequested(params: params));
  }
}
