import 'dart:convert';
import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/core/utils/url_launcher.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:dh_employer/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AccountDeletePage extends StatefulWidget {
  const AccountDeletePage({super.key});

  @override
  State<AccountDeletePage> createState() => _AccountDeletePageState();
}

class _AccountDeletePageState extends State<AccountDeletePage> {

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
        Get.offAllNamed(homePageRoute);
      },
      child: const Icon(
        Iconsax.arrow_left,
        color: AppColors.white,
      ),
    ),
    leadingWidth: 52,
    title: Text(
      StringConst.deleteTitle.tr,
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
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getAppBar,
            const Image(image: AssetImage('assets/images/delete_account.png')),
            Column(
              children: [
                const Text('Your account is archived \nfor now...',
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
            Padding(padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
             child: CustomPrimaryButton(
               text: StringConst.textButton.tr,
               textColor: AppColors.white,
               onPressed: () => UrlLauncher.launchEmail(data['errors']['email']),
             ),
            )
          ],
        ),
      ),
    );
  }

  Widget get _emptyArticleText {
    return Column(
      children: const [
         Text(
          'After 30 days, your account will be',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
         SizedBox(
          height: 10,
        ),
         Text(
          ' permanently deleted. If you want to recover ',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
         SizedBox(
          height: 10,
        ),
         Text(
          'your account within these 30 days, please',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
         SizedBox(
          height: 10,
        ),
         Text(
          'click “Send Email” to write us. ',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
         SizedBox(height: 10),
      ],
    );
  }
}
