// ad_helper.dart
import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8523082947927931/2435233289';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8523082947927931/3939886648';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8523082947927931/9185254714';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8523082947927931/4578142908';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}