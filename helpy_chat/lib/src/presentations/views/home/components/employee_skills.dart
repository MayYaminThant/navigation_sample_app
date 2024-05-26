import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/utils/db_utils.dart';
import '../../../values/values.dart';

class EmployeeSkills extends StatefulWidget {
  const EmployeeSkills(
      {super.key,
      required this.onValueChanged,
      required this.initialList,
      this.textColor,
      required this.prefix});

  final ValueChanged<List<String>> onValueChanged;
  final List<String> initialList;
  final Color? textColor;
  final String? prefix;

  @override
  State<EmployeeSkills> createState() => _EmployeeSkillsState();
}

class _EmployeeSkillsState extends State<EmployeeSkills> {
  final List<String> _employeeSkillList = [];

  List<String> selectedList = [];

  @override
  void initState() {
    _getMemberTypesData();
    super.initState();
    if (widget.initialList.isNotEmpty) {
      selectedList = widget.initialList;
    }
  }

  @override
  void didUpdateWidget(covariant EmployeeSkills oldWidget) {
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
        StringConst.employeeSkillText.tr,
        style:
            TextStyle(color: widget.textColor ?? AppColors.white, fontSize: 16),
      );

  Widget get getSkillContainer => Container(
        padding: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: AppColors.primaryGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.0),
          border:
              selectedList.isEmpty ? Border.all(color: AppColors.red) : null,
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
                    style: TextStyle(
                        color: widget.textColor ?? AppColors.primaryGrey,
                        fontSize: 12)),
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

  //Skills Data List
  Future<void> _getMemberTypesData() async {
    final List<dynamic>? data = await DBUtils.getKeyDataList(widget.prefix);
    if (data != null) {
      List<String> dataList = List<String>.from(data);
      setState(() {
        _employeeSkillList.addAll(dataList);
      });
    }
  }
}
