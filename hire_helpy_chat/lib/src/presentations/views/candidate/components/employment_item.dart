import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/entities.dart';

class EmploymentItem extends StatefulWidget {
  final Employment employment;

  const EmploymentItem({
    Key? key,
    required this.employment,
  }) : super(key: key);

  @override
  State<EmploymentItem> createState() => _EmploymentItemState();
}

class _EmploymentItemState extends State<EmploymentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.only(top: 23, left: 12, bottom: 16),
      width: 328,
      // height: 226,
      decoration: BoxDecoration(
          border: const GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Color(0xFFFFB6A0),
              Color(0xFFA5E3FD),
              Color(0xFF778AFF),
              Color(0xFFFFCBF2),
            ]),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: _getContentCart(),
    );
  }

  Widget _getContentCart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSavedSearchCountryAndName(),
            _buildYear(),
          ],
        ),
        _buildInfoText(),
        if (widget.employment.dhRelated!) _getDHRelated
      ],
    );
  }

  Widget _buildSavedSearchCountryAndName() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  widget.employment.countryName ?? '',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            StringConst.workDescriptionTitle,
            style: TextStyle(
              color: AppColors.articleBackgroundColor,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYear() {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Text(
        '${getYearOnly(widget.employment.startDate ?? '')} - ${getYearOnly(widget.employment.endDate ?? '')}',
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          widget.employment.desc ?? '',
          style: const TextStyle(
            color: AppColors.articleBackgroundColor,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _popMenuButtonInterviewCompleted() {
    return PopupMenuButton<String>(
      color: Colors.transparent,
      offset: const Offset(30, -7),
      elevation: 0,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            height: 4,
            value: 'editWorkExperience',
            child: Container(
              height: 47,
              width: 157,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor),
              child: const Center(
                child: Text(
                  'Edit Work Experience',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          PopupMenuItem<String>(
            height: 4,
            value: 'delete',
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 47,
              width: 157,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyBg),
              child: const Center(
                child: Text(
                  'Delete',
                  style: TextStyle(
                      color: AppColors.greyShade2,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ];
      },
      child: const Icon(Icons.more_vert, color: Colors.white),
    );
  }

  Widget get _getDHRelated => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                Container(
                  width: 21,
                  height: 21,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.brandBlue),
                  child: Image.asset(
                    'assets/icons/check.png',
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'DH Related',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandBlue),
                ),
              ],
            ),
          ),
        ],
      );

  getYearOnly(String dateString) {
    if (dateString == '') return '';
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM yyyy').format(date);
  }
}
