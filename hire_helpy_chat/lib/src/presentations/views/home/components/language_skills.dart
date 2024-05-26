import 'package:dh_employer/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../values/values.dart';

class LanguageSkills extends StatefulWidget {
  const LanguageSkills(
      {super.key, required this.onValueChanged, required this.initialList, this.textColor});

  final ValueChanged<List<String>> onValueChanged;
  final List<String> initialList;
  final Color? textColor;

  @override
  State<LanguageSkills> createState() => _LanguageSkillsState();
}

class _LanguageSkillsState extends State<LanguageSkills> {
  final List<String> _employeeSkillList = [
    'Proficient English',
    'Chinese Mandarin',
    'Bahasa Melayu',
    'Tamil',
    'Hokkien',
    'Tecochew',
    'Cantonese',
    'Bahasa Indonesian',
    'Japanese',
    'Korean',
    'French',
    'German',
  ];

  List<String> selectedList = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialList.isNotEmpty) selectedList = widget.initialList;
  }

  @override
  void didUpdateWidget(covariant LanguageSkills oldWidget) {
    selectedList = widget.initialList;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        getEmployeeSkillTitle,
        const SizedBox(
          height: 20,
        ),
        getSkillContainer,
      ],
    );
  }

  Widget get getEmployeeSkillTitle => Text(
        StringConst.languageSkillsText,
        style: TextStyle(color: widget.textColor?? AppColors.white, fontSize: 16),
      );

  Widget get getSkillContainer => Container(
        padding: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: AppColors.primaryGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.0),
          border: selectedList.isEmpty
              ? Border.all(color: AppColors.red)
              : null,
        ),
        child: _getSkillListView,
      );

  ListView get _getSkillListView => ListView.builder(
      itemCount: _employeeSkillList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: CustomCheckBox(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                leading: Text(_employeeSkillList[index],
                    style: const TextStyle(
                        color: AppColors.primaryGrey, fontSize: 12)),
                initialValue: selectedList.contains(_employeeSkillList[index]),
                onValueChanged: (bool value) {
                  if (value) {
                    selectedList.add(_employeeSkillList[index]);
                  } else {
                    selectedList.remove(_employeeSkillList[index]);
                  }
                  widget.onValueChanged(selectedList);
                },
              ),
            ),
            index != _employeeSkillList.length - 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:
                        Divider(color: AppColors.primaryGrey.withOpacity(0.5)),
                  )
                : const SizedBox(
                    height: 20,
                  )
          ],
        );
      });
}
