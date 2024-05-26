import 'dart:io' show Platform;

import 'package:dh_mobile/src/core/utils/constants.dart';
import 'package:dh_mobile/src/core/utils/version_helper.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/background_scaffold.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateSection extends StatelessWidget {
  const ForceUpdateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
        scaffold: Scaffold(
      body: _mainContent(context),
    ));
  }

  Widget _mainContent(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/no-image-bg.png'),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: _contentColumn,
      ),
    );
  }

  Widget get _contentColumn {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
                height: 287,
                width: 287,
                child: Image(
                    image: AssetImage('assets/images/update_require.png'))),
            const Spacer(
              flex: 1,
            ),
            Text(
              StringConst.forceUpdateTitle.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(flex: 1),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Text(
                  StringConst.forceUpdateContent.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                )),
            const Spacer(flex: 5),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
                child: CustomPrimaryButton(
                  heightButton: 47,
                  text: StringConst.forceUpdateButton.tr,
                  fontSize: 20,
                  onPressed: () => _openStore(),
                )),
          ],
        ),
      ),
      Positioned(bottom: 10, left: 16, child: _versionNumberDisplay)
    ]);
  }

  Widget get _versionNumberDisplay {
    return FutureBuilder(
        future: VersionHelper.getCurrentAppVersion(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!.versionString,
              style: TextStyle(color: Colors.grey.withAlpha(100)),
            );
          }
          return Container();
        });
  }

  void _openStore() {
    if (Platform.isAndroid || Platform.isIOS) {
      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=$kBundleId"
            : "https://apps.apple.com/app/id$kAppleAppId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
