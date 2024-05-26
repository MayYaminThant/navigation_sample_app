import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../domain/entities/entities.dart';

class JobsInfo extends StatefulWidget {
  const JobsInfo(
      {super.key,
      required this.candidate,
      required this.fontSize,
      required this.paddingSize});
  final Candidate candidate;
  final double fontSize;
  final double paddingSize;

  @override
  State<JobsInfo> createState() => _JobsInfoState();
}

class _JobsInfoState extends State<JobsInfo> {
  final List<String> familyInformationList = [];

  final List<String> languageList = [];

  List<String> restDayList = [];
  Color familyColor = AppColors.secondaryColor,
      langugeColor = AppColors.secondaryColor,
      skillColor = AppColors.secondaryColor;

  @override
  void initState() {
    super.initState();
    _getConfigsData();
    _addFamilyInformation();
    _addLanguages();
    restDayList = widget.candidate.restDayChoice != null
        ? [
            '${widget.candidate.restDayChoice == 0 ? 'No' : widget.candidate.restDayChoice} Rest days (/Month)'
          ]
        : [];
  }

  @override
  Widget build(BuildContext context) {
    return _getJobsInfoList;
  }

  //Jobs Info List
  Wrap get _getJobsInfoList => Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: [
          ..._getRequirements(),
          ..._getLanguages(),
          ..._getRestDays()
        ],
      );

  //Requirement List
  List<Widget> _getRequirements() => List<Widget>.generate(
      familyInformationList.length,
      (int index) => _getInfoItem(familyColor, familyInformationList[index]));

  //Language List
  List<Widget> _getLanguages() => List<Widget>.generate(languageList.length,
      (int index) => _getInfoItem(langugeColor, languageList[index]));

  //Language List
  List<Widget> _getRestDays() => List<Widget>.generate(restDayList.length,
      (int index) => _getInfoItem(skillColor, restDayList[index]));

  _getInfoItem(Color color, String text) => Container(
        padding: EdgeInsets.all(widget.paddingSize),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w400),
        ),
      );

  void _getConfigsData() async {
    familyColor = await DBUtils.getKeyDataList(kFamilyTagConfig) != null
        ? AppColors.fromHex(await DBUtils.getKeyDataList(kFamilyTagConfig))
        : AppColors.secondaryColor;

    langugeColor = await DBUtils.getKeyDataList(kLanguageTagConfig) != null
        ? AppColors.fromHex(await DBUtils.getKeyDataList(kLanguageTagConfig))
        : AppColors.secondaryColor;

    skillColor = await DBUtils.getKeyDataList(kSkillTagConfig) != null
        ? AppColors.fromHex(await DBUtils.getKeyDataList(kSkillTagConfig))
        : AppColors.secondaryColor;
    setState(() {});
  }

  _addFamilyInformation() {
    if (widget.candidate.familyStatus != '' &&
        widget.candidate.familyStatus != null) {
      familyInformationList.add(widget.candidate.familyStatus ?? '');
    }
  }

  _addLanguages() {
    if (widget.candidate.languageProficientEnglish != null &&
        widget.candidate.languageProficientEnglish!) {
      languageList.add('Proficient English');
    }
    if (widget.candidate.languageChineseMandarin != null &&
        widget.candidate.languageChineseMandarin!) {
      languageList.add('Chinese Mandarin');
    }
    if (widget.candidate.languageBahasaMelayu != null &&
        widget.candidate.languageBahasaMelayu!) {
      languageList.add('Bahasa Melayu');
    }
    if (widget.candidate.languageTamil != null &&
        widget.candidate.languageTamil!) {
      languageList.add('Tamil');
    }
    if (widget.candidate.languageHokkien != null &&
        widget.candidate.languageHokkien!) {
      languageList.add('Hokkien');
    }
    if (widget.candidate.languageTeochew != null &&
        widget.candidate.languageTeochew!) {
      languageList.add('Tecochew');
    }
    if (widget.candidate.languageCantonese != null &&
        widget.candidate.languageCantonese!) {
      languageList.add('Cantonese');
    }
    if (widget.candidate.languageBahasaIndonesian != null &&
        widget.candidate.languageBahasaIndonesian!) {
      languageList.add('Bahasa Indonesian');
    }
    if (widget.candidate.languageJapanese != null &&
        widget.candidate.languageJapanese!) {
      languageList.add('Japanese');
    }
    if (widget.candidate.languageKorean != null &&
        widget.candidate.languageKorean!) {
      languageList.add('Korean');
    }
    if (widget.candidate.languageFrench != null &&
        widget.candidate.languageFrench!) {
      languageList.add('French');
    }
    if (widget.candidate.languageGerman != null &&
        widget.candidate.languageGerman!) {
      languageList.add('German');
    }
    if (widget.candidate.languageOthersSpecify != '' &&
        widget.candidate.languageOthersSpecify != null) {
      languageList.add(widget.candidate.languageOthersSpecify ?? '');
    }
  }

  // Color _getColorFromConfig(String name) {
  //   return configList.indexWhere((f) => f.name.toString() == name) != -1
  //       ? AppColors.fromHex(
  //           configList[configList.indexWhere((f) => f.name.toString() == name)]
  //               .value
  //               .toString())
  //       : AppColors.secondaryColor;
  // }
}
