// ad_helper.dart
import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8523082947927931/8729140907';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8523082947927931/5855603541';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8523082947927931/4003427835';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8523082947927931/9255754510';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}