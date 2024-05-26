// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:dh_employer/src/core/utils/configs_key_helper.dart';
import 'package:dh_employer/src/core/utils/db_utils.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hive/hive.dart';

import '../../candidate/components/employer_flag.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/time_utils.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';
import 'rename_search_modal.dart';

class SavedSearchCard extends StatefulWidget {
  final SavedSearch savedSearch;

  const SavedSearchCard({Key? key, required this.savedSearch})
      : super(key: key);

  @override
  State<SavedSearchCard> createState() => _SavedSearchCardState();
}

class _SavedSearchCardState extends State<SavedSearchCard> {
  Map? employerData;

  List<SavedSearch> savedSearchList = [];
  List<String> skillList = [];

  @override
  void initState() {
    _getEmployerData();
    super.initState();
    _addSkills();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    employerData = box.get(DBUtils.employerTableName);
  }

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
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchCountryNameAndSalary(),
            _buildInfoText(),
            _buildWrap()
          ],
        ),
        // Positioned(
        //   top: 0,
        //   right: 2,
        //   child: ,
        // ),
      ],
    );
  }

  Widget _buildWrap() {
    return Wrap(
      spacing: 8,
      children: skillList.isNotEmpty
          ? skillList.map((data) {
              int index = skillList.indexWhere((f) => f == data);
              final color = index % 2 == 0 ? AppColors.skyBlue : AppColors.pink;

              return Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Text(
                  data,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              );
            }).toList()
          : [],
    );
  }

  Widget _buildSearchCountryNameAndSalary() {
    return Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildCountryNameAndTime(), _buildSalary()]));
  }

  Widget _buildCountryNameAndTime() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          EmployerFlag(
            country: widget.savedSearch.country ?? '',
            marginValue: 0.0,
            configKey: ConfigsKeyHelper.adSearchDHNationalityKey,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              widget.savedSearch.name != ''
                  ? widget.savedSearch.name!
                  : widget.savedSearch.country!,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      Padding(
          padding: const EdgeInsets.only(top: 2), child: _buildSearchTime()),
    ]);
  }

  Widget _buildSalary() {
    return Column(children: [
      Row(children: [
        Text(
          '${widget.savedSearch.currency} ${widget.savedSearch.offeredSalary.toString()}  ',
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        _popMenuButtonInterviewCompleted()
      ]),
      const Text(
        'per month',
        style: TextStyle(
          color: AppColors.articleBackgroundColor,
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
      )
    ]);
  }

  Widget _buildSearchTime() {
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          widget.savedSearch.createdAt == null
              ? ''
              : 'Searched at ${apiDatetimeToLocal(widget.savedSearch.createdAt!, "dd/MM/yyyy")}',
          style: const TextStyle(
            color: AppColors.articleBackgroundColor,
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
        ));
  }

  Widget _buildInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        // Text(
        //   '${StringConst.agentFeeText}: ${widget.savedSearch.agentFee} ${widget.savedSearch.agentFee! <= 1 ? 'Month' : 'Months'}',
        //   style: const TextStyle(
        //     color: AppColors.articleBackgroundColor,
        //     fontWeight: FontWeight.normal,
        //     fontSize: 12,
        //   ),
        // ),
        const SizedBox(height: 4),
        Text(
          '${StringConst.startDateText}: ${widget.savedSearch.startDate == null ? '' : formatDate(widget.savedSearch.startDate!, "dd/MM/yyyy")}',
          style: const TextStyle(
            color: AppColors.articleBackgroundColor,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${StringConst.restDaysText}: ${widget.savedSearch.restDayChoice} ${widget.savedSearch.restDayChoice != null && widget.savedSearch.restDayChoice! > 1 || widget.savedSearch.restDayChoice! == 0 ? 'Days' : 'Day'}',
          style: const TextStyle(
            color: AppColors.articleBackgroundColor,
            fontWeight: FontWeight.normal,
            fontSize: 12,
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
            value: 'expandedSearchValue',
            child: Container(
              height: 47,
              width: 157,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor),
              child: const Center(
                child: Text(
                  'Expand Search',
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
            value: 'renameSearchValue',
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 47,
              width: 157,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF5BD8FF)),
              child: const Center(
                child: Text(
                  'Rename Search',
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
            value: 'removeSearchValue',
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 47,
              width: 157,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyBg),
              child: const Center(
                child: Text(
                  'Remove Search',
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
      onSelected: (String value) {
        Get.back();
        if (value == 'expandedSearchValue') {
          Get.toNamed(advancedSearchPageRoute,
              parameters: {'data': json.encode(widget.savedSearch)});
        }
        if (value == 'renameSearchValue') {
          _showRenameModal();
        }
        if (value == 'removeSearchValue') {
          _removeSaveSearch();
        }
      },
      onOpened: () =>
          showDialog(context: context, builder: (context) => Container()),
      child: const Icon(Icons.more_vert, color: Colors.white),
      onCanceled: () => Get.back(),
    );
  }

  void _showRenameModal() {
    showDialog(
      context: context,
      builder: (context) => RenameSearchModal(
        onSave: (enteredText) {
          _renameSaveSearch(enteredText);
          Get.back();
          Get.back();
        },
      ),
    );
  }

  _removeSaveSearch() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerDeleteSaveSearchRequestParams params =
        EmployerDeleteSaveSearchRequestParams(
      saveSearchId: widget.savedSearch.id,
      token: employerData!['token'],
    );
    employerBloc.add(EmployerDeleteSaveSearchRequested(params: params));
  }

  _renameSaveSearch(String name) {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerUpdateSaveSearchRequestParams params =
        EmployerUpdateSaveSearchRequestParams(
            saveSearchId: widget.savedSearch.id,
            token: employerData!['token'],
            name: name);
    employerBloc.add(EmployerUpdateSaveSearchRequested(params: params));
  }

  _addSkills() {
    if (widget.savedSearch.skillGeneralHousework!) {
      _checkAddSkill('General Housework');
    }
    if (widget.savedSearch.skillInfantCare!) {
      _checkAddSkill('Infant Care');
    }
    if (widget.savedSearch.skillElderlyCare!) {
      _checkAddSkill('Elderly Care');
    }
    if (widget.savedSearch.skillPetCare!) {
      _checkAddSkill('Pet Care');
    }
    if (widget.savedSearch.skillCooking!) {
      _checkAddSkill('Cooking');
    }
    if (widget.savedSearch.skillSpecialNeedsCare!) {
      _checkAddSkill('Special Needs Care');
    }
    if (widget.savedSearch.skillbedriddenCare!) {
      _checkAddSkill('Bedidden Care');
    }
    if (widget.savedSearch.skillHandicapCare!) {
      _checkAddSkill('Handicap Care');
    }
  }

  void _checkAddSkill(String skilleName) {
    if (!skillList.contains(skilleName)) {
      skillList.add(skilleName);
    }
  }
}
