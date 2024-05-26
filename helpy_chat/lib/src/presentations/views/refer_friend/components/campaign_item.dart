import 'package:dh_mobile/src/core/utils/configs_key_helper.dart';
import 'package:dh_mobile/src/core/utils/db_utils.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/views/refer_friend/components/default_campaign_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';

import 'campaign_declaration.dart';

class CampaignItem extends StatefulWidget {
  const CampaignItem({super.key});

  @override
  State<CampaignItem> createState() => _CampaignItemState();
}

class _CampaignItemState extends State<CampaignItem> {
  //DefaultCampaignItem(),

  int createAccountAmount = 0;
  String startDate = '';
  String endDate = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  _initializeData() async {
    var data =
        await DBUtils.getKeyDataList(ConfigsKeyHelper.referralCreateAccountKey);
    if (data != null) {
      setState(() {
        createAccountAmount = data['amount'] ?? 0;
        startDate = data['start_date'] ?? '';
        endDate = data['end_date'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return createAccountAmount != 0
        ? _getCampaignItemContainer
        : const DefaultCampaignItem();
  }

  get _getCampaignItemContainer {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: const GradientBoxBorder(
          gradient: LinearGradient(colors: [
            Color(0xFFFFB6A0),
            Color(0xFFA5E3FD),
            Color(0xFF778AFF),
            Color(0xFFFFCBF2),
          ]),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConst.newYearCampaign.tr,
            style: const TextStyle(
                color: AppColors.cardColor,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Refer Your Friends to get ',
                  style: TextStyle(color: Colors.grey, height: 2, fontSize: 14),
                ),
                TextSpan(
                  text: 'up to 200 Phluid Coins',
                  style: TextStyle(color: Colors.orange, fontSize: 14),
                ),
                TextSpan(
                  text: ' Per Successful Referral!',
                  style: TextStyle(color: Colors.grey, height: 2, fontSize: 14),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          Row(
            children: [
              Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/refer_friend_2.png'))),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${StringConst.validDate.tr} \n( ${_getDateFormat(startDate)} - ${_getDateFormat(endDate)} )',
                      style: const TextStyle(
                          color: AppColors.secondaryColor, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () => _showTermAndCondition(),
                      child:  SizedBox(
                        width: 170,
                        child: Text(
                          StringConst.seeTandC.tr,
                          style:const TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _showTermAndCondition() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const CampaignDeclarationModal();
      },
    );
  }

  _getDateFormat(String date) {
    return DateFormat('dd.MM.yyyy').format(DateTime.parse(date));
  }
}
