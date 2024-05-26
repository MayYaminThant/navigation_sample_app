import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/routes/routes.dart';
import '../../../widgets/widgets.dart';

class RegisterEnjoyPopUp extends StatelessWidget {
  const RegisterEnjoyPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: _getRegisterPopUpEnjoy(),
    );
  }

  Widget _getRegisterPopUpEnjoy() {
    return Container(
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
                      height: 4,
                    ),
                    CustomPrimaryButton(
                      text: 'Register Now',
                      fontSize: 12,
                      heightButton: 40,
                      widthButton: 130,
                      onPressed: () => Get.toNamed(registerPageRoute),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: CustomImageView(
                  image: 'assets/images/register-pop-up-enjoy.png',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
