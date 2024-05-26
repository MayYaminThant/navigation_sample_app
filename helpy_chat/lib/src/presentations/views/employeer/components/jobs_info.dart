import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../domain/entities/entities.dart';

class JobsInfo extends StatefulWidget {
  const JobsInfo(
      {super.key,
      required this.employer,
      required this.fontSize,
      required this.paddingSize,
      this.fontColor});

  final Employer employer;
  final double fontSize;
  final double paddingSize;
  final Color? fontColor;

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

    restDayList = widget.employer.offer?.restDay != null
        ? [
            '${widget.employer.offer!.restDay == 0 ? 'No' : widget.employer.offer!.restDay} Rest days (/Month)'
          ]
        : [];
  }

  @override
  Widget build(BuildContext context) {
    return _getJobsInfoList;
  }

  //Jobs Info List
  Widget get _getJobsInfoList => Wrap(
        spacing: 7.0,
        runSpacing: 10.0,
        clipBehavior: Clip.hardEdge,
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

  Widget _getInfoItem(Color color, String text) => Container(
        padding: EdgeInsets.all(widget.paddingSize),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          text,
          style: TextStyle(
              color: widget.fontColor ?? Colors.white,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w400),
        ),
      );

  Future<void> _getConfigsData() async {
    Color fColor = await DBUtils.getKeyDataList(kFamilyTagConfig) != null
        ? AppColors.fromHex(await DBUtils.getKeyDataList(kFamilyTagConfig))
        : AppColors.secondaryColor;

    Color lColor = await DBUtils.getKeyDataList(kLanguageTagConfig) != null
        ? AppColors.fromHex(await DBUtils.getKeyDataList(kLanguageTagConfig))
        : AppColors.secondaryColor;

    Color sColor = await DBUtils.getKeyDataList(kSkillTagConfig) != null
        ? AppColors.fromHex(await DBUtils.getKeyDataList(kSkillTagConfig))
        : AppColors.secondaryColor;
    setState(() {
      familyColor = fColor;
      langugeColor = lColor;
      skillColor = sColor;
    });
  }

  void _addFamilyInformation() {
    if (widget.employer.familyStatus != '') {
      familyInformationList.add(widget.employer.familyStatus ?? '');
    }
  }

  void _addLanguages() {
    if (widget.employer.languageProficientEnglish ?? false) {
      languageList.add('Proficient English');
    }
    if (widget.employer.languageChineseMandarin ?? false) {
      languageList.add('Chinese Mandarin');
    }
    if (widget.employer.languageBahasaMelayu ?? false) {
      languageList.add('Bahasa Melayu');
    }
    if (widget.employer.languageTamil ?? false) {
      languageList.add('Tamil');
    }
    if (widget.employer.languageHokkien ?? false) {
      languageList.add('Hokkien');
    }
    if (widget.employer.languageTeochew ?? false) {
      languageList.add('Tecochew');
    }
    if (widget.employer.languageCantonese ?? false) {
      languageList.add('Cantonese');
    }
    if (widget.employer.languageBahasaIndonesian ?? false) {
      languageList.add('Bahasa Indonesian');
    }
    if (widget.employer.languageJapanese ?? false) {
      languageList.add('Japanese');
    }
    if (widget.employer.languageKorean ?? false) {
      languageList.add('Korean');
    }
    if (widget.employer.languageFrench ?? false) {
      languageList.add('French');
    }
    if (widget.employer.languageGerman ?? false) {
      languageList.add('German');
    }
    if (widget.employer.languageOthersSpecify != '') {
      languageList.add(widget.employer.languageOthersSpecify ?? '');
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
