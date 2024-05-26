import 'package:date_time_picker/date_time_picker.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
    required this.controller,
    required this.isInitialDate,
    this.isShowPreviousDate,
    required this.enabled,
    this.backgroundColor,
    this.textColor,
    this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isInitialDate;
  final bool? isShowPreviousDate;
  final bool enabled;
  final Color? backgroundColor;
  final Color? textColor;
  final String? hintText;

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  void initState() {
    super.initState();
    if (widget.isInitialDate) {
      widget.controller.text =
          getMonthYearFormatDate(DateTime.now()).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.white.withOpacity(0.1),
          //border: Border.all(color: AppColors.primaryGrey.withOpacity(0.5)),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: AppColors.primaryColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: DateTimePicker(
            type: DateTimePickerType.date,
            enabled: widget.enabled,
            dateMask: 'yyyy-MM-dd',
            controller: widget.controller,
            firstDate: _getFirstDate(),
            lastDate: DateTime(2100),
            style: TextStyle(
                fontSize: 14, color: widget.textColor ?? AppColors.black),
            decoration: InputDecoration(
                hintText: widget.hintText ?? 'YYYY-MM-DD',
                hintStyle:
                    const TextStyle(fontSize: 14, color: AppColors.primaryGrey),
                border: InputBorder.none,
                suffixIcon: const Icon(
                  Iconsax.calendar5,
                  color: AppColors.primaryGrey,
                  size: 20,
                )),
            onChanged: (val) => setState(() => widget.controller.text = val),
            validator: (val) {
              setState(() => widget.controller.text = val ?? '');
              return null;
            },
            onSaved: (val) =>
                setState(() => widget.controller.text = val ?? ''),
          ),
        ),
      ),
    );
  }

  _getFirstDate() {
    if (widget.isShowPreviousDate!) {
      return DateTime(1900);
    } else {
      return DateTime.now();
    }
  }

  getMonthYearFormatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
