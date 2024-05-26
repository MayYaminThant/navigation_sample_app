import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";
const String prefSelectedCountryCode = "SelectedCountryCode";


Future<void> setLocale(String languageCode, String countryCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(prefSelectedLanguageCode, languageCode);
  prefs.setString(prefSelectedCountryCode, countryCode);
}


Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(prefSelectedLanguageCode) ?? "en";
  String countryCode = prefs.getString(prefSelectedCountryCode) ?? "US";
  return _locale(languageCode, countryCode);
}

Locale _locale(String languageCode,String countryCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, countryCode)
      : const Locale('en', 'US');
}