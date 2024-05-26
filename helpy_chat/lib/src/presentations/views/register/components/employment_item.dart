import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/views/register/components/employment_history_update_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';

import '../../../../core/params/params.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';

class EmploymentItem extends StatefulWidget {
  final Employment employment;
  final String token;
  final int userId;
  final bool isShowMenu;

  const EmploymentItem(
      {Key? key,
      required this.employment,
      required this.token,
      required this.userId,
      required this.isShowMenu})
      : super(key: key);

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
      child: _getContentCart,
    );
  }

  Widget get _getContentCart => Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSavedSearchCountryAndName,
                  _buildYear(),
                ],
              ),
              _buildInfoText(),
              if (widget.employment.dhRelated!) _getDHRelated
            ],
          ),
          widget.isShowMenu
              ? Positioned(
                  top: 0,
                  right: 2,
                  child: _popMenuButtonInterviewCompleted(),
                )
              : Container(),
        ],
      );

  Widget get _buildSavedSearchCountryAndName => Expanded(
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
            Text(
              StringConst.workDescriptionTitle.tr,
              style: const TextStyle(
                color: AppColors.articleBackgroundColor,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );

  Widget _buildYear() {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Text(
        '${getYearOnly(widget.employment.startDate ?? '')} - ${widget.employment.endDate != null ? getYearOnly(widget.employment.endDate!) : 'current'}',
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor),
              child: Center(
                child: Text(
                  'Edit Work Experience'.tr,
                  style: const TextStyle(
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyBg),
              child: Center(
                child: Text(
                  'Delete'.tr,
                  style: const TextStyle(
                      color: AppColors.greyShade2,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ];
      },
      onSelected: (String value) {
        switch (value) {
          case 'editWorkExperience':
            _editWorkExperience();
            break;
          case 'delete':
            _deleteWorkExperience();
            break;
          default:
            break;
        }
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
                Text(
                  'DH Related'.tr,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandBlue),
                ),
              ],
            ),
          ),
        ],
      );

  String getYearOnly(String dateString) {
    if (dateString == '') return '';
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM yyyy').format(date);
  }

  void _deleteWorkExperience() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateDeleteEmploymentRequestParams params =
        CandidateDeleteEmploymentRequestParams(
      employmentID: widget.employment.id,
      token: widget.token,
    );
    candidateBloc.add(CandidateDeleteEmploymentRequested(params: params));
  }

  void _editWorkExperience() {
    showDialog(
      context: context,
      builder: (context) => EmploymentHistoryUpdateModal(
        token: widget.token,
        userId: widget.userId,
        onSave: (enteredText) {},
        employment: widget.employment,
      ),
    );
  }
}
