import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums/language_enums.dart';
import '../../constants/enums/shared_keys_enums.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _appLocale;

  Locale get appLocal => _appLocale ?? const Locale("en");

  fetchLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(SharedKeysEnums.languageCode.key) == null) {
      _appLocale = const Locale('en');
    } else {
      Locale localeLang =
          Locale(prefs.getString(SharedKeysEnums.languageCode.key)!);
      if (localeLang == Locale(LanguageEnums.tr.language)) {
        _appLocale = const Locale('tr');
      } else if (localeLang == Locale(LanguageEnums.en.language)) {
        _appLocale = const Locale('en');
      } else if (localeLang == const Locale('de')) {
        _appLocale = const Locale('de');
      } else if (localeLang == const Locale('ja')) {
        _appLocale = const Locale('ja');
      } else if (localeLang == const Locale('ar')) {
        _appLocale = const Locale('ar');
      }
    }
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (type == const Locale("tr")) {
      _appLocale = const Locale("tr");
      await prefs.setString('language_code', 'tr');
    } else if (type == const Locale("en")) {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
    } else if (type == const Locale("de")) {
      _appLocale = const Locale("de");
      await prefs.setString('language_code', 'de');
    } else if (type == const Locale("ja")) {
      _appLocale = const Locale("ja");
      await prefs.setString('language_code', 'ja');
    } else if (type == const Locale("ar")) {
      _appLocale = const Locale("ar");
      await prefs.setString('language_code', 'ar');
    }
    notifyListeners();
  }
}
