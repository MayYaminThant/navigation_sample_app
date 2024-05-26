import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/entities.dart';
import '../../../values/values.dart';

class ReferFriendItem extends StatelessWidget {
  const ReferFriendItem({super.key, required this.referFriend, required this.coin});
  final ReferFriend referFriend;
  final String coin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 321,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.cardColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${referFriend.firstName} ${referFriend.lastName} has successfully verified!',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                _getFormatedDateTime(),
                style: const TextStyle(
                  color: AppColors.secondaryGrey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: AppColors.green,
            child: Text(
              '+$coin',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getFormatedDateTime() {
    return DateFormat('dd MMM, yyyy')
        .format(DateTime.parse(referFriend.phoneNumberPVerifiedDatetime ?? ''));
  }
}
