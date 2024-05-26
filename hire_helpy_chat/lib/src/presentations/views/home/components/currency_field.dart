import 'package:dh_employer/src/core/utils/snackbar_utils.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:dh_employer/src/presentations/widgets/widgets.dart';
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
    super.initState();
    value = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant CurrencyField oldWidget) {
    if (widget.initialValue != '' &&
        oldWidget.initialValue != widget.initialValue) {
      value = widget.initialValue;
      if (oldWidget.initialValue != '') widget.controller.text = '';
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getCurrencyField(context);
    }, listener: (_, state) {
      if (state is EmployerExchangeRateLoading) {
        setState(() {
          conversionLoading = true;
        });
      }

      if (state is EmployerExchangeRateSuccess) {
        if (state.data.data != null) {
          setState(() {
            widget.controller.text =
                (state.data.data!['data']['converted_amount'] ?? '').toString();
            conversionLoading = false;
          });
        }
      }

      if (state is EmployerExchangeRateFail) {
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
  _getCurrencyField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0)),
      child: Stack(children: [ Table(
        columnWidths: const {
          0: FixedColumnWidth(80),
        },
        children: [
          TableRow(
              children: [_getCurrencyDropDown, _getCurrencyTextField(context)])
        ],
      ),
        if (conversionLoading) Positioned.fill(
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
      ])
    );
  }

  //Currency DropDown
  Widget get _getCurrencyDropDown => CurrencyDropDownItem(
      initialValue: value,
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
      prefix: widget.prefix);

  //Currency TextField
  _getCurrencyTextField(BuildContext context) => CustomTextField(
        width: MediaQuery.of(context).size.width,
        controller: widget.controller,
        textInputType: TextInputType.number,
        enabled: widget.enabled ?? true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        hasTitle: false,
        hasSuffixIcon: false,
        isRequired: true,
        // textFormFieldMargin:
        //     const EdgeInsets.symmetric(vertical: 10),
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
        onChanged: (value) => _checkExchangeRate(value),
        decoration: BoxDecoration(
            color: Colors.black.withAlpha(10),
            border: isInvalid ? Border.all(color: AppColors.red) : null,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
      );

  _checkExchangeRate(String value) async {
    var data = await StringUtils.getExchangeList();

    for (int i = 0; i < data.length; i++) {
      if (data[i]['currency_code'] == selectedCurrencyCode) {
        if (data[i]['MAX_MONTHLY_SALARY'] <
            int.parse(value != '' ? value : '0')) {
          // ignore: use_build_context_synchronously
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

  void _requestExchange(String base, String target) {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerExchangeRateRequestParams params =
        EmployerExchangeRateRequestParams(
            base: base,
            target: target,
            baseAmount: double.parse(widget.controller.text));
    candidateBloc.add(EmployerExchangeRateRequested(params: params));
  }
}
