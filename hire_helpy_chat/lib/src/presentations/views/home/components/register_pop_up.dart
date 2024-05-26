import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/widgets.dart';

class RegisterPopUp extends StatelessWidget {
  const RegisterPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: _getRegisterPopUp(context),
    );
  }

  Widget _getRegisterPopUp(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      height: 450,
      width: 326,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.greyBg,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/images/registe-home.png',
              )),
          const Text(
            StringConst.createAccountText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.greyShade2,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          CustomPrimaryButton(
            text: StringConst.registerAccountText,
            fontSize: 12,
            customColor: AppColors.primaryColor,
            textColor: AppColors.white,
            heightButton: 47,
            widthButton: MediaQuery.of(context).size.width - 40,
            onPressed: () => Get.offNamed(registerPageRoute),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomPrimaryButton(
            text: StringConst.backToSearchText,
            fontSize: 12,
            customColor: AppColors.white,
            textColor: AppColors.primaryColor,
            heightButton: 47,
            widthButton: MediaQuery.of(context).size.width - 40,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
