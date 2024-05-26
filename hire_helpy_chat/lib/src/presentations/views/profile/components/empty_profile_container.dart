import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/routes/routes.dart';
import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class EmptyProfileContainer extends StatelessWidget {
  const EmptyProfileContainer({super.key, this.route});
  final String? route;

  @override
  Widget build(BuildContext context) {
    return _getEmptyContainer(context);
  }

  _getEmptyContainer(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 60),
              child: Icon(
                Iconsax.warning_25,
                size: 60,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Please create a Simple Profile for your candidates to know more about you!',
              style: TextStyle(
                color: AppColors.primaryGrey,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomPrimaryButton(
              text: StringConst.goToProfileCreationText.tr,
              widthButton: 268,
              customColor: AppColors.primaryColor,
              textColor: AppColors.white,
              onPressed: () {
                Navigator.of(context).pop();
                Get.toNamed(aboutMePageRoute, parameters: {'route': route ?? ''});
              },
            ),
          ],
        ),
      );
}
