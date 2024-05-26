import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../translations/locale_constant.dart';

class LanguageUtils {
  static const englishOnly = false;

  static void changeLanguage(String language) {
    if (englishOnly) {
      updateLocale(const Locale('en', 'US'));
      return;
    }

    switch (language) {
      case 'Burmese':
        updateLocale(
          const Locale('my', 'MM'),
        );
        break;

      case 'Bahasa Indonesia':
        updateLocale(
          const Locale('in', 'id'),
        );
        break;

      case 'Filipino':
        updateLocale(
          const Locale('tl', 'tl'),
        );
        break;
      default:
        updateLocale(
          const Locale('en', 'US'),
        );
        break;
    }
  }

  static void updateLocale(Locale locale) {
    setLocale(locale.languageCode, locale.countryCode!);
    Get.updateLocale(locale);
  }
}
