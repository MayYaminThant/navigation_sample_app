import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';


class DefaultCampaignItem extends StatefulWidget {
  const DefaultCampaignItem({super.key});

  @override
  State<DefaultCampaignItem> createState() => _DefaultCampaignItemState();
}

class _DefaultCampaignItemState extends State<DefaultCampaignItem> {
  @override
  Widget build(BuildContext context) {
    return _getDefaultCampaignItemContainer;
  }

  get _getDefaultCampaignItemContainer {
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
          const Text(
            'Refer Your Friends To Help Secure A Job!',
            style: TextStyle(
                color: AppColors.cardColor,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          const SizedBox(height: 10,),
          Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                        image: AssetImage('assets/images/refer_friend_1.png'))),
              ),
        ],
      ),
    );
  }

}
