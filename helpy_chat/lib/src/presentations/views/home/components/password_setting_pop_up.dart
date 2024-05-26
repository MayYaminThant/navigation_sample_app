import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class PasswordSettingPopUp extends StatelessWidget {
  const PasswordSettingPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: _getPasswordsSettingsPopUp);
  }

  Widget get _getPasswordsSettingsPopUp {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 25),
        height: 379,
        width: 326,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.greyBg,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Please Set your Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.greyShade2,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            CustomImageView(
              image: 'assets/images/unlocking.png',
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'You have not set the password yet.\nPlease update it for easy log in and your account safety',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.articleBackgroundColor,
                  fontSize: 12,
                ),
              ),
            ),
            CustomPrimaryButton(
              text: 'Update Password',
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
