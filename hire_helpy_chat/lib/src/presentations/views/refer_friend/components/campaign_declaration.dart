import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/utils/configs_key_helper.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../values/values.dart';

class CampaignDeclarationModal extends StatefulWidget {
  const CampaignDeclarationModal({super.key});

  @override
  State<CampaignDeclarationModal> createState() =>
      _CampaignDeclarationModalState();
}

class _CampaignDeclarationModalState extends State<CampaignDeclarationModal> {
  String bullet = "\u2022 ";

  int createAccountAmount = 0;
  int verifyAmount = 0;
  int verifyWorkPermit = 0;
  int verifiedReferal = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  _initializeData() async {
    var createAccountdata =
        await DBUtils.getKeyDataList(ConfigsKeyHelper.referralCreateAccountKey);
    if (createAccountdata != null) {
      setState(() {
        createAccountAmount = createAccountdata['amount'] ?? 0;
      });
    }

    var refererVerifydata =
        await DBUtils.getKeyDataList(ConfigsKeyHelper.refererVerifyKey);
    if (refererVerifydata != null) {
      setState(() {
        verifyAmount = refererVerifydata['amount'] ?? 0;
      });
    }

    var verifyWorkPermitdata =
        await DBUtils.getKeyDataList(ConfigsKeyHelper.refererWorkPermitKey);
    if (verifyWorkPermitdata != null) {
      setState(() {
        verifyWorkPermit = verifyWorkPermitdata['amount'] ?? 0;
      });
    }

    var verifiedReferaldata =
        await DBUtils.getKeyDataList(ConfigsKeyHelper.refereeWorkPermitKey);
    if (verifiedReferaldata != null) {
      setState(() {
        verifiedReferal = verifiedReferaldata['amount'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          return SizedBox(
            child: _getDeclarationContainer,
          );
        },
      ),
    );
  }

  Widget get _getDeclarationContainer => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringConst.termsAndConditionTitle.tr,
            style: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            """The definition of Referrer is you.
The Definition of Referee is any of your friends who you refer.\n\nFor each referee that you refer. 
""",
            style:
                TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14),
          ),
          getRichText(
              'Referee Download And Create An Account, Referrer Will Get',
              createAccountAmount),
          getRichText(
              'Referee Verified Phone Number, Referrer Will Get', verifyAmount),
          getRichText(
              'Referee Verifies Singapore Domestic Helper Work Permit, Referrer Gets',
              verifyWorkPermit),
          getRichText(
              'Referee Verifies Singapore Domestic Helper Work Permit, Referee Will Get',
              verifiedReferal),
        ],
      );

  getRichText(String first, int second) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '$bullet $first ',
            style: TextStyle(
                color: Colors.black.withOpacity(0.7), height: 2, fontSize: 14),
          ),
          TextSpan(
            text: second.toString(),
            style: const TextStyle(color: Colors.orange, fontSize: 14),
          ),
          TextSpan(
            text: ' PHC.',
            style: TextStyle(
                color: Colors.black.withOpacity(0.7), height: 2, fontSize: 14),
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}
