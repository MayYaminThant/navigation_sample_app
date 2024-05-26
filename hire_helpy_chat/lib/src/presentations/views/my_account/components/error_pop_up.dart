
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class ErrorPopUp extends StatelessWidget {
  const ErrorPopUp({super.key, this.onAgreePressed, required this.title, this.subTitle});
  final VoidCallback? onAgreePressed;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return _getErrorPopUp(context);
  }

  _getErrorPopUp(context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 300,
          width: 326,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.greyBg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 40),
                child: Icon(
                  Iconsax.warning_25,
                  size: 60,
                  color: AppColors.red,
                ),
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
              subTitle != null ? Text(
                subTitle ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.primaryGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ): const SizedBox.shrink(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomPrimaryButton(
                    text: StringConst.cancelRequestText,
                    fontSize: 12,
                    heightButton: 47,
                    customColor: Colors.grey,
                    widthButton: MediaQuery.of(context).size.width / 2.7,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CustomPrimaryButton(
                    text: StringConst.agreeText,
                    fontSize: 12,
                    heightButton: 47,
                    customColor: AppColors.red,
                    widthButton: MediaQuery.of(context).size.width / 2.7,
                    onPressed: onAgreePressed,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorPopUpNotification extends StatelessWidget {
  const ErrorPopUpNotification({super.key, this.onAgreePressed, required this.title, required this.subTitle});
  final VoidCallback? onAgreePressed;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return _getErrorPopUpNotification(context);
  }

  _getErrorPopUpNotification(context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 300,
          width: 326,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.greyBg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 40),
                child: Icon(
                  Iconsax.warning_25,
                  size: 60,
                  color: AppColors.red,
                ),
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
                subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.primaryGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPrimaryButton(
                    text: 'Ok',
                    fontSize: 12,
                    heightButton: 47,
                    customColor: Colors.grey,
                    widthButton: MediaQuery.of(context).size.width / 2.7,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}