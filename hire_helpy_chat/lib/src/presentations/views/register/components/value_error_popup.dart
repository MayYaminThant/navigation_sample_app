import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class ValueErrorPopup extends StatelessWidget {
  const ValueErrorPopup(
      {super.key,
      required this.values,
      required this.messages,
      required this.nextRoute,
      required this.currentRoute,
      this.isExit
      });
  final List<String> values;
  final List<String> messages;
  final String nextRoute;
  final String currentRoute;
  final bool? isExit;

  @override
  Widget build(BuildContext context) {
    return _getEmptyContainer(context);
  }

  _getEmptyContainer(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
              'You need to fill up these information to proceed.'.tr,
              style: const TextStyle(
                color: AppColors.primaryGrey,
                fontSize: 18,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            _getErrorMessages(),
            const SizedBox(
              height: 20,
            ),
            if(isExit == null) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlineButton(
                  text: 'Close',
                  widthButton: 110,
                  heightButton: 47,
                  customColor: Colors.transparent,
                  textColor: AppColors.primaryColor,
                  onPressed: () => Navigator.of(context).pop(),
                  fontSize: 12,
                ),
                CustomPrimaryButton(
                  text: 'Skip For Now',
                  widthButton: 110,
                  heightButton: 47,
                  customColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  fontSize: 12,
                  onPressed: () => _createSkipForNow(context),
                ),
              ],
            )
          ],
        ),
      );

  _getErrorMessages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < values.length; i++)
          if (values[i] == '' || values[i] == '0')
            Text(
              '\u2022 ${messages[i].tr}',
              style: const TextStyle(
                color: AppColors.red,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
      ],
    );
  }

  _createSkipForNow(context) {
    Navigator.of(context).pop();
    Get.toNamed(nextRoute, parameters: {'route': currentRoute});
  }
}
