import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class UnLinkValidationModal extends StatelessWidget {
  const UnLinkValidationModal(
      {super.key,
      this.onPressed
      });
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
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            
            Text(
              "Are you sure you want to unlink with this person? If you unlink, all the conversation messages between the two of you will be deleted at the same time.".tr,
              style: const TextStyle(
                height: 1.5,
                color: AppColors.black,
                fontSize: 15,
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
                CustomOutlineButton(
                  text: 'No',
                  widthButton: 110,
                  heightButton: 47,
                  customColor: Colors.transparent,
                  textColor: AppColors.primaryColor,
                  onPressed: () => Navigator.of(context).pop(),
                  fontSize: 12,
                ),
                CustomPrimaryButton(
                        text: 'Yes',
                        widthButton: 110,
                        heightButton: 47,
                        customColor: AppColors.primaryColor,
                        textColor: AppColors.white,
                        fontSize: 12,
                        onPressed: onPressed,
                      )
              ],
            )
          ],
        ),
      );

}
