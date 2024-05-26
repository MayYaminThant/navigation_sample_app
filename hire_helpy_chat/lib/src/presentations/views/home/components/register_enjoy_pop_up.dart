import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/routes/routes.dart';
import '../../../widgets/widgets.dart';

class RegisterEnjoyPopUp extends StatelessWidget {
  const RegisterEnjoyPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return _getRegisterPopUpEnjoy();
  }

  Widget _getRegisterPopUpEnjoy() {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0, bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Start Joining Phluid',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.greyShade2,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        StringConst.registerModalText,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColors.articleBackgroundColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomPrimaryButton(
                        text: 'Register Now',
                        fontSize: 12,
                        heightButton: 34,
                        widthButton: 130,
                        onPressed: () => Get.toNamed(registerPageRoute),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: CustomImageView(
                    imagePath: 'assets/images/register-pop-up-enjoy.png',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
