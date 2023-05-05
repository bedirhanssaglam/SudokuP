import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums/language_enums.dart';
import '../../constants/enums/shared_keys_enums.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _appLocale;

  Locale get appLocal => _appLocale ?? Locale(LanguageEnums.en.language);

  fetchLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(SharedKeysEnums.languageCode.key) == null) {
      _appLocale = Locale(LanguageEnums.en.language);
    } else {
      Locale localeLang =
          Locale(prefs.getString(SharedKeysEnums.languageCode.key)!);
      _appLocale = localeLang;
    }
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (type == Locale(LanguageEnums.tr.language)) {
      _appLocale = Locale(LanguageEnums.tr.language);
      await prefs.setString(
          SharedKeysEnums.languageCode.key, LanguageEnums.tr.language);
    } else if (type == Locale(LanguageEnums.en.language)) {
      _appLocale = Locale(LanguageEnums.en.language);
      await prefs.setString(
          SharedKeysEnums.languageCode.key, LanguageEnums.en.language);
    } else if (type == Locale(LanguageEnums.de.language)) {
      _appLocale = Locale(LanguageEnums.de.language);
      await prefs.setString(
          SharedKeysEnums.languageCode.key, LanguageEnums.de.language);
    } else if (type == Locale(LanguageEnums.ja.language)) {
      _appLocale = Locale(LanguageEnums.ja.language);
      await prefs.setString(
          SharedKeysEnums.languageCode.key, LanguageEnums.ja.language);
    } else if (type == Locale(LanguageEnums.ar.language)) {
      _appLocale = Locale(LanguageEnums.ar.language);
      await prefs.setString(
          SharedKeysEnums.languageCode.key, LanguageEnums.ar.language);
    }
    notifyListeners();
  }
}
