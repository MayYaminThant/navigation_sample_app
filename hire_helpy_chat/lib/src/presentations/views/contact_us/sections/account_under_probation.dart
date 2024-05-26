import 'dart:convert';

import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AccountUnderProbationScreen extends StatefulWidget {
  const AccountUnderProbationScreen({super.key});

  @override
  State<AccountUnderProbationScreen> createState() =>
      _AccountUnderProbationScreenState();
}

class _AccountUnderProbationScreenState
    extends State<AccountUnderProbationScreen> {
  Map data = {};

  @override
  void initState() {
    super.initState();
    if (Get.parameters.isNotEmpty) {
      String message = Get.parameters['data'] ?? '';
      data = json.decode(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getEmptyScaffold;
  }

  Scaffold get _getEmptyScaffold {
    return Scaffold(
      body: SafeArea(top: false, child: _getEmptyArticleContainer),
    );
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          'Contact Us'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w200),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
      );

  Widget get _getEmptyArticleContainer {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getAppBar,
              const Image(image: AssetImage('assets/images/no-probation.png')),
              Column(
                children: [
                  const Text('Your account is currently \nunder Evaluation.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 20,
                  ),
                  _emptyArticleText,
                ],
              ),
              // Padding(padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
              //   child: CustomPrimaryButton(
              //     text: StringConst.textButton.tr,
              //     textColor: AppColors.white,
              //     onPressed: () => UrlLauncher.launchEmail(data['errors']['email']),
              //   ),
              // )
            ],
          ),
        ));
  }

  Widget get _emptyArticleText {
    return Column(
      children: [
        const Text(
          'There had been some complaints filed',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          ' against you. Fret not, we are working on it ',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'right now. Your account will be unlocked',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          ' once the misunderstanding is cleared up by',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        const Text(
          ' our Review Board in 48 hrs.',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        const Text(
          ' Meanwhile you can read our policy',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        RichText(
            text: TextSpan(children: [
          const TextSpan(
            text: 'guidelines by clicking on this',
            style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryGrey,
                fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: ' link ',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(termsAndPolicyRoute, arguments: 1);
              },
            style: const TextStyle(
                fontSize: 15,
                color: AppColors.skyBlue,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline),
          ),
        ])),
        const SizedBox(height: 10),
        const Text(
          'You can try to login in after 48 hrs or click',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        RichText(
            text: TextSpan(children: [
          const TextSpan(
            text: 'this',
            style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryGrey,
                fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: ' link ',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(contactUsPageRoute);
              },
            style: const TextStyle(
                fontSize: 15,
                color: AppColors.skyBlue,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline),
          ),
          const TextSpan(
            text: 'to email us.',
            style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryGrey,
                fontWeight: FontWeight.w400),
          ),
        ])),
      ],
    );
  }
}
