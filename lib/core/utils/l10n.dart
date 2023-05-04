import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sudoku_app/core/constants/enums/icon_enums.dart';
import 'package:sudoku_app/core/constants/enums/language_enums.dart';

@immutable
class L10n {
  const L10n._();

  static List<Locale> support = [
    Locale(LanguageEnums.en.language),
    Locale(LanguageEnums.tr.language),
    Locale(LanguageEnums.de.language),
    Locale(LanguageEnums.ja.language),
    Locale(LanguageEnums.ar.language),
  ];

  static const List<LocalizationsDelegate<Object>> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static String checkLanguageIcon(String languageName) {
    switch (languageName) {
      case "Turkish":
        return IconEnums.turkish.iconName;
      case "English":
        return IconEnums.english.iconName;
      case "German":
        return IconEnums.germany.iconName;
      case "Japanese":
        return IconEnums.japan.iconName;
      case "Arabic":
        return IconEnums.arabic.iconName;
      default:
        return IconEnums.english.iconName;
    }
  }

  static String setLanguage(String languageName) {
    switch (languageName) {
      case "Turkish":
        return LanguageEnums.tr.language;
      case "English":
        return LanguageEnums.en.language;
      case "German":
        return LanguageEnums.de.language;
      case "Japanese":
        return LanguageEnums.ja.language;
      case "Arabic":
        return LanguageEnums.ar.language;
      default:
        return LanguageEnums.en.language;
    }
  }
}
