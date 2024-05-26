import 'package:dh_mobile/src/core/utils/constants.dart';
import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'environment_manager.dart';

class ShortLink {
  static Future<Uri> createShortLink(String loginName, String url) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("$apiUrl/$loginName"),
      uriPrefix: url,
      navigationInfoParameters:
          const NavigationInfoParameters(forcedRedirectEnabled: false),
      androidParameters: const AndroidParameters(
        packageName: kBundleId,
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: kBundleId,
        minimumVersion: '0',
        appStoreId: '6461165550',
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable);
    return dynamicLink.shortUrl;
  }

  static Future<Uri> createProfileShortLink(
      String loginName, String url) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("$apiUrl/profile/$loginName"),
      uriPrefix: url,
      navigationInfoParameters:
          const NavigationInfoParameters(forcedRedirectEnabled: false),
      androidParameters: const AndroidParameters(
        packageName: kBundleEmoployerId,
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: kBundleEmoployerId,
        minimumVersion: '0',
        appStoreId: '6459793048',
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable);
    superPrint(dynamicLink.shortUrl);
    return dynamicLink.shortUrl;
  }

  static Future<Uri> createEmployerProfileShortLink(
      String loginName, String url) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("$apiUrl/profile/$loginName"),
      uriPrefix: url,
      navigationInfoParameters:
          const NavigationInfoParameters(forcedRedirectEnabled: false),
      androidParameters: const AndroidParameters(
        packageName: kBundleId,
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: kBundleId,
        minimumVersion: '0',
        appStoreId: '6459793048',
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable);
    return dynamicLink.shortUrl;
  }

  static Future<Uri> createArticleShortLink(
      String artileID, String url, String type) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("$apiUrl/$type/$artileID"),
      uriPrefix: url,
      navigationInfoParameters:
          const NavigationInfoParameters(forcedRedirectEnabled: false),
      androidParameters: const AndroidParameters(
        packageName: kBundleId,
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: kBundleId,
        minimumVersion: '0',
        appStoreId: '6461165550',
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable);
    return dynamicLink.shortUrl;
  }
}
