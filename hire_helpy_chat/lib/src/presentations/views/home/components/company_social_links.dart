
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/url_launcher.dart';
import '../../../values/values.dart';

class CompanySocialLinks extends StatefulWidget {
  const CompanySocialLinks({super.key});

  @override
  State<CompanySocialLinks> createState() => _CompanySocialLinksState();
}

class _CompanySocialLinksState extends State<CompanySocialLinks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_getHomeFollowUs, _getSocialMedia],
    );
  }

  //Follow Us
  Widget get _getHomeFollowUs => Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: const Text(
            StringConst.followUsText,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      );

  //Social Media
  Widget get _getSocialMedia => Row(
        children: [
          getSocialMediaItem('facebook.png', kFacebookUrl),
          const SizedBox(
            width: 10,
          ),
          getSocialMediaItem('instagram.png', kInstagramUrl),
          const SizedBox(
            width: 10,
          ),
         getSocialMediaItem('twitter.png', kTwitterUrl),
         const SizedBox(
            width: 10,
          ),
         getSocialMediaItem('tiktok.png', kTiktokUrl),
         const SizedBox(
            width: 10,
          ),
         getSocialMediaItem('linkedin.png', kLinkedInUrl),

        ],
      );

  getSocialMediaItem(String image, String url) => GestureDetector(
      onTap: () => UrlLauncher.launchURL(url),
      child: SizedBox(
        width: 24,
        height: 24,
        child: Image.asset('assets/icons/$image'),
      ),
    );
}
