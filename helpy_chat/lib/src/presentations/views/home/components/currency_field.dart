import 'package:dh_mobile/src/core/utils/snackbar_utils.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../blocs/blocs.dart';

class CurrencyField extends StatefulWidget {
  const CurrencyField({
    super.key,
    required this.initialValue,
    required this.onValueChanged,
    required this.controller,
    this.backgroundColor,
    this.textColor,
    required this.prefix,
    this.enabled,
    this.hintText,
  });

  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final TextEditingController controller;
  final Color? backgroundColor;
  final Color? textColor;
  final String prefix;
  final bool? enabled;
  final String? hintText;

  @override
  State<CurrencyField> createState() => _CurrencyFieldState();
}

class _CurrencyFieldState extends State<CurrencyField> {
  String value = '';
  String selectedCurrencyCode = '';
  bool isInvalid = false;
  bool conversionLoading = false;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _getCurrencyField;
    }, listener: (_, state) {
      if (state is CandidateExchangeRateLoading) {
        setState(() {
          conversionLoading = true;
        });
      }

      if (state is CandidateExchangeRateSuccess) {
        if (state.data.data != null) {
          setState(() {
            widget.controller.text =
                "${state.data.data!['data']['converted_amount']}";
          });
        }
        setState(() {
          conversionLoading = false;
        });
      }

      if (state is CandidateExchangeRateFail) {
        setState(() {
          conversionLoading = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  //Currency Field with Dropdown and TextField
  Widget get _getCurrencyField => Container(
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppColors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0)),
        child: Stack(children: [
          Table(
            columnWidths: const {
              0: FixedColumnWidth(90),
            },
            children: [
              TableRow(children: [_getCurrencyDropDown, _getCurrencyTextField])
            ],
          ),
          if (conversionLoading)
            Positioned.fill(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withAlpha(120),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ))))),
        ]),
      );

  //Currency DropDown
  Widget get _getCurrencyDropDown {
    return CurrencyDropDownItem(
        initialValue: value == "Others" ? "Singapore" : value,
        title: 'Currency',
        textColor: widget.textColor,
        onValueChanged: (String data) {
          if (selectedCurrencyCode != data &&
              selectedCurrencyCode != '' &&
              widget.controller.text.isNotEmpty) {
            _requestExchange(selectedCurrencyCode, data);
          }
          setState(() {
            selectedCurrencyCode = data;
          });
          widget.onValueChanged(data);
        },
        iconPadding: 0,
        prefix: widget.prefix,
        showFlag: false);
  }

  //Currency TextField
  Widget get _getCurrencyTextField => CustomTextField(
        width: MediaQuery.of(context).size.width,
        controller: widget.controller,
        textInputType: TextInputType.number,
        enabled: widget.enabled ?? true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        hasTitle: false,
        hasSuffixIcon: false,
        isRequired: true,
        titleStyle: TextStyle(
          color: widget.textColor ?? AppColors.white,
          fontSize: Sizes.textSize14,
        ),
        hasTitleIcon: false,
        enabledBorder: Borders.noBorder,
        focusedBorder: Borders.noBorder,
        hintTextStyle: TextStyle(
          color: widget.textColor ?? AppColors.primaryGrey,
          fontSize: Sizes.textSize14,
        ),
        textStyle: TextStyle(color: widget.textColor ?? AppColors.primaryGrey),
        hintText: widget.hintText,
        onChanged: (value) async => await _checkExchangeRate(value),
        decoration: BoxDecoration(
            color: Colors.black.withAlpha(10),
            border: isInvalid ? Border.all(color: AppColors.red) : null,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
      );

  Future<void> _checkExchangeRate(String value) async {
    var data = await StringUtils.getExchangeList();
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        if (data[i]['currency_code'] == selectedCurrencyCode) {
          if (data[i]['MAX_MONTHLY_SALARY'] <
              int.parse(value != '' ? value : '0')) {
            if (!mounted) return;
            showErrorSnackBar(
                'The monthly salary amount you keyed in is not in sync with market practices. Please kindly try a lower amount.');
            setState(() {
              isInvalid = true;
            });
            break;
          }
        } else {
          setState(() {
            isInvalid = false;
          });
        }
      }
    }
  }

  void _requestExchange(String base, String target) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateExchangeRateRequestParams params =
        CandidateExchangeRateRequestParams(
            base: base,
            target: target,
            baseAmount: double.parse(widget.controller.text));
    candidateBloc.add(CandidateExchangeRateRequested(params: params));
  }
}
