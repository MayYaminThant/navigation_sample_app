import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../widgets/widgets.dart';

class RevealSearchPopUp extends StatefulWidget {
  const RevealSearchPopUp(
      {super.key, required this.candidateData, required this.isAdvancedSearch});
  final Map<String, dynamic> candidateData;
  final bool isAdvancedSearch;

  @override
  State<RevealSearchPopUp> createState() => _RevealSearchPopUpState();
}

class _RevealSearchPopUpState extends State<RevealSearchPopUp> {
  Map? employerData;

  @override
  void initState() {
    _getEmployerData();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: _getRegisterPopUpEnjoy(context),
    );
  }

  Widget _getRegisterPopUpEnjoy(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: 300,
      width: 326,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.greyBg,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            StringConst.searchResultsText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryGrey,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${widget.candidateData['data']['profiles'].length} ${widget.candidateData['data']['profiles'].length > 1 ? StringConst.matchesFoundText : StringConst.matchFoundText}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.greyShade2,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            children: [
              CustomPrimaryButton(
                  text: employerData == null
                      ? 'Create Account to Reveal Matches'
                      : 'Reveal Matches',
                  fontSize: 12,
                  heightButton: 47,
                  widthButton: MediaQuery.of(context).size.width - 40,
                  onPressed: () => employerData == null
                      ? Get.offAllNamed(registerPageRoute,
                          parameters: {"route": rootRoute})
                      : Get.offAllNamed(searchResultPageRoute)),
              const SizedBox(
                height: 15,
              ),
              CustomPrimaryButton(
                text: StringConst.backToSearchText,
                fontSize: 12,
                customColor: AppColors.white,
                textColor: AppColors.primaryColor,
                heightButton: 47,
                widthButton: MediaQuery.of(context).size.width - 40,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (widget.isAdvancedSearch) Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
