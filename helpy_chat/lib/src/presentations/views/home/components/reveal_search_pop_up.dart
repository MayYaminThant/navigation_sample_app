import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../widgets/widgets.dart';

class RevealSearchPopUp extends StatefulWidget {
  const RevealSearchPopUp(
      {super.key, required this.employerData, required this.isAdvancedSearch});

  final Map<String, dynamic> employerData;
  final bool isAdvancedSearch;

  @override
  State<RevealSearchPopUp> createState() => _RevealSearchPopUpState();
}

class _RevealSearchPopUpState extends State<RevealSearchPopUp> {
  Map? candidateData;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
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
          Text(
            StringConst.searchResultsText.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.primaryGrey,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${widget.employerData['data']['profiles'].length} ${widget.employerData['data']['profiles'].length == 1 ? StringConst.matchFoundText : StringConst.matchesFoundText}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.greyShade2,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPrimaryButton(
                  text: candidateData == null
                      ? StringConst.createAccountToRevealMatchesText
                      : StringConst.revealMatchesText,
                  fontSize: 12,
                  heightButton: 47,
                  widthButton: MediaQuery.of(context).size.width - 40,
                  onPressed: candidateData == null
                      ? () => Get.offAllNamed(registerPageRoute,
                          parameters: {"route": rootRoute})
                      : "${widget.employerData['data']['profiles']}".length > 1
                          ? null
                          : () => Get.offAllNamed(searchResultPageRoute)),
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
