import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class DeclarationRequestModal extends StatefulWidget {
  const DeclarationRequestModal({super.key});

  @override
  State<DeclarationRequestModal> createState() =>
      _DeclarationRequestModalState();
}

class _DeclarationRequestModalState extends State<DeclarationRequestModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: _getDeclarationContainer,
    );
  }

  Widget get _getDeclarationContainer => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.greyBg,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'How to improve your chances for chat request',
                style: TextStyle(color: AppColors.black, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              _getDeclarationNo1(),
              const SizedBox(
                height: 10,
              ),
               _getDeclarationNo2(),
              const SizedBox(
                height: 10,
              ),
               _getDeclarationNo3(),
              const SizedBox(
                height: 10,
              ),
               _getDeclarationNo4(),
              const SizedBox(
                height: 10,
              ),
               _getDeclarationNo5(),
              const SizedBox(
                height: 10,
              ),
               _getDeclarationNo6(),
              const SizedBox(
                height: 20,
              ),

              CustomPrimaryButton(
                text: 'Got It',
                fontSize: 12,
                heightButton: 47,
                widthButton: MediaQuery.of(context).size.width,
                onPressed: () => _checkValidation(),
              ),
            ],
          ),
        ),
      );

  //Declaration CheckBoxs
  _getDeclarationCheckBox(String title) {
    return Text(title,
        textAlign: TextAlign.justify,
        style:
            TextStyle(color: AppColors.black.withOpacity(0.3), fontSize: 12));
  }

  _checkValidation() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  _getDeclarationNo1() => const Text.rich(TextSpan(
        children: [
          TextSpan(
            text: '1) Change your ',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
          TextSpan(
              text: 'availability status',
              style: TextStyle(
                  color: AppColors.primaryColor, fontSize: 12)),
          TextSpan(
            text:
                'to green dot … or yellow dot …. The status … with the green dot will automatically be prioritized by our AI recommendation engine. ',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
        ],
      ));

  _getDeclarationNo2() => const Text.rich(TextSpan(
        children: [
          TextSpan(
            text: '2) Upload interesting pictures and videos of yourself to improve your chances. Our AI recommendation engine will prioritize profiles with high view counts.',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
        ],
      ));

  _getDeclarationNo3() => const Text.rich(TextSpan(
        children: [
          TextSpan(
            text: '3) Complete all fields in your ',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
          TextSpan(
              text: 'Profile',
              style: TextStyle(
                  color: AppColors.primaryColor, fontSize: 12)),
          TextSpan(
            text:
                ' Page and upload an interesting icon of yourself. BTW, you get Phluid Coin rewards too other than improving the chances of connecting.',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
        ],
      ));
  
  _getDeclarationNo4() => Text.rich(TextSpan(
        children: [
          const TextSpan(
            text: '4) Refer your friends to our platform with the "',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
          TextSpan(
              text: 'Refer A Friend'.tr,
              style: const TextStyle(
                  color: AppColors.primaryColor, fontSize: 12)),
          const TextSpan(
            text:
                '” feature, to show you are actively building your community. And yes, you get Phluid Coin rewards along the way as well!',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
        ],
      ));
  
  _getDeclarationNo5() => const Text.rich(TextSpan(
        children: [
          TextSpan(
            text: '5) Give ',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
          TextSpan(
              text: 'Reviews',
              style: TextStyle(
                  color: AppColors.primaryColor, fontSize: 12)),
          TextSpan(
            text:
                ' to your connections after chatting with them to show your engagement on our platform.',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
        ],
      ));


  _getDeclarationNo6() => const Text.rich(TextSpan(
        children: [
          TextSpan(
            text: '6) Last of all! ',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
          TextSpan(
              text: 'Search',
              style: TextStyle(
                  color: AppColors.primaryColor, fontSize: 12)),
          TextSpan(
            text:
                ' for more matching profiles and reach out more to get more connections! It is a number game!',
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
        ],
      ));
}
