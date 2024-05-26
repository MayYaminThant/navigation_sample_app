import 'package:dh_employer/src/core/utils/constants.dart';
import 'package:dh_employer/src/core/utils/environment_manager.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class ShortLink {
  static createShortLink(String loginName, String url) async {
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
        appStoreId: '6459793048',
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable);
    return dynamicLink.shortUrl;
  }

  static createProfileShortLink(String loginName, String url) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("$apiUrl/profile/$loginName"),
      uriPrefix: url,
      navigationInfoParameters:
          const NavigationInfoParameters(forcedRedirectEnabled: false),
      androidParameters: const AndroidParameters(
        packageName: kBundleCandidateId,
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: kBundleCandidateId,
        minimumVersion: '0',
        appStoreId: '6461165550',
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable);
    return dynamicLink.shortUrl;
  }

  static createCandidateProfileShortLink(String loginName, String url) async {
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
        appStoreId: '6461165550',
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable);
    return dynamicLink.shortUrl;
  }

  static createArticleShortLink(
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
        appStoreId: '6459793048',
      ),
    );
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable);
    return dynamicLink.shortUrl;
  }
}
