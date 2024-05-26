import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class MessageSentPopUp extends StatelessWidget {
  const MessageSentPopUp({super.key, required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _getSentMessagePopUp;
  }

  Widget get _getSentMessagePopUp {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 207,
          width: 326,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.greyBg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustomImageView(
                image: 'assets/icons/send_icon.png',
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.greyShade2,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.articleBackgroundColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
