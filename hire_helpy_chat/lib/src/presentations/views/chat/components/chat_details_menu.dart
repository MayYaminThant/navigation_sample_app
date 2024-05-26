import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:iconsax/iconsax.dart';

import '../../../values/values.dart';

class CheckDetailMenuDropDown extends StatefulWidget {
  const CheckDetailMenuDropDown({
    Key? key,
    required this.conversationId,
    required this.onValueChanged,
  }) : super(key: key);
  final String conversationId;
  final ValueChanged<String> onValueChanged;

  @override
  State<CheckDetailMenuDropDown> createState() =>
      _CheckDetailMenuDropDownState();
}

class _CheckDetailMenuDropDownState extends State<CheckDetailMenuDropDown> {
  List<String> menuList = [
    'Hire this Helper through Phluid NOW'.tr,
    'Clear Messages',
    'Comment on Candidate',
    'Complaint Violation'
  ];
  List<IconData> iconsList = [
    Iconsax.profile_circle,
    Iconsax.trash,
    Iconsax.message,
    Iconsax.warning_2
  ];
  late String value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return menuList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PopupMenuButton<String>(
              onSelected: _handleClick,
              constraints: const BoxConstraints.tightFor(width: 250),
              offset: const Offset(0, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return menuList.map((String choice) {
                  return PopupMenuItem<String>(
                      value: choice,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getIcon(choice),
                                color: AppColors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 160,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    choice.tr,
                                    style: const TextStyle(
                                        fontSize: 12, color: AppColors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider()
                        ],
                      ));
                }).toList();
              },
              child: Container(
                child: _getActionBarItem,
              ),
            ),
          )
        : Container();
  }

  Widget get _getActionBarItem {
    return const Icon(Icons.more_vert);
  }

  void _handleClick(String data) {
    setState(() {
      value = data;
      widget.onValueChanged(data);
    });
  }

  IconData? _getIcon(String data) {
    int index = menuList.indexWhere((item) => item == data);
    return iconsList[index];
  }
}
