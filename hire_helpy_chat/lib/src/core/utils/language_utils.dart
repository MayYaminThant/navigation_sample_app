import 'package:dh_employer/src/core/utils/configs_key_helper.dart';
import 'package:dh_employer/src/data/models/models.dart';
import 'package:dh_employer/src/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../translations/locale_constant.dart';
import 'db_utils.dart';

class LanguageUtils {
  // TODO: UPDATE LANGUAGE SELECTION OPTIONS FROM HERE
  static Future<List<ConfigLanguage>> getFirstTimeLoadConfigLanguages() async {
    List<ConfigLanguage> dataList = await _getConfigLanguagesWithKey(
        ConfigsKeyHelper.firstTimeLoadLanguageKey);
    return dataList;
    // return [const ConfigLanguage(languageName: "Default", language: "English" )];
  }

  static Future<List<ConfigLanguage>> getMyAccountFormConfigLanguages() async {
    List<ConfigLanguage> dataList = await _getConfigLanguagesWithKey(
        ConfigsKeyHelper.myAccountFormLanguageKey);
    return dataList;
  }

  static Future<List<ConfigLanguage>> getArticleConfigLanguages() async {
    List<ConfigLanguage> dataList =
        await _getConfigLanguagesWithKey(ConfigsKeyHelper.articleLanguageKey);
    return dataList;
  }

  static Future<List<ConfigLanguage>> getArticleCreateConfigLanguages() async {
    List<ConfigLanguage> dataList = await _getConfigLanguagesWithKey(
        ConfigsKeyHelper.articleCreateLanguageKey);
    return dataList;
  }

  static Future<List<ConfigLanguage>> _getConfigLanguagesWithKey(
      String key) async {
    try {
      List<ConfigLanguage> dataList = List<ConfigLanguage>.from(
          (await DBUtils.getKeyDataList(key))
              .map((e) => ConfigLanguageModel.fromJson(e)));
      return dataList;
    } catch (e) {
      return [
        const ConfigLanguage(languageName: 'Default', language: 'English')
      ];
    }
  }

  static changeLanguage(String language, BuildContext context) {
    switch (language) {
      // case 'English':
      //   updateLocale(
      //     const Locale('en', 'US'),
      //     context,
      //   );
      //   break;

      case 'Burmese':
        updateLocale(
          const Locale('my', 'MM'),
          context,
        );
        break;

      case 'Bahasa Indonesia':
        updateLocale(
          const Locale('in', 'id'),
          context,
        );
        break;

      case 'Filipino':
        updateLocale(
          const Locale('tl', 'tl'),
          context,
        );
        break;
      default:
        updateLocale(
          const Locale('en', 'US'),
          context,
        );
        break;
    }
  }

  static updateLocale(Locale locale, BuildContext context) {
    setLocale(locale.languageCode, locale.countryCode!);
    Get.updateLocale(locale);
  }
}
