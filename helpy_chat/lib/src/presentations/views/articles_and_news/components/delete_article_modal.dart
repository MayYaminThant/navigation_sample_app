import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class DeleteArticleModal extends StatelessWidget {
  const DeleteArticleModal({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return _getEmptyContainer(context);
  }

  _getEmptyContainer(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Icon(
                    Iconsax.warning_25,
                    size: 60,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Would you like to delete the article".tr,
              style: const TextStyle(
                  height: 1.5,
                  color: AppColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Text(
              "articlesDeletePermanent".tr,
              style: const TextStyle(
                height: 1.5,
                color: AppColors.primaryGrey,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              // ignore: unnecessary_null_comparison
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomPrimaryButton(
                  text: 'Yes',
                  widthButton: 110,
                  heightButton: 47,
                  customColor: AppColors.red,
                  textColor: AppColors.white,
                  fontSize: 12,
                  onPressed: onPressed,
                ),
                CustomOutlineButton(
                  text: 'No',
                  widthButton: 110,
                  heightButton: 47,
                  customColor: Colors.transparent,
                  textColor: AppColors.primaryGrey,
                  onPressed: () => Navigator.of(context).pop(),
                  fontSize: 12,
                ),
              ],
            )
          ],
        ),
      );
}
