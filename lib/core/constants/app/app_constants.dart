import 'package:flutter/foundation.dart' show immutable;

import '../enums/icon_enums.dart';

@immutable
class AppConstants {
  const AppConstants._();

  static const String appName = "SudokuP";
  static const String test = 'test';
  static const String beginner = 'beginner';
  static const String easy = 'easy';
  static const String medium = 'medium';
  static const String hard = 'hard';

  static List<Map<String, String>> splashData = [
    {
      "text":
          "SudokuP is a highly functional app where you can solve random sudoku quizzes of all levels.\nLet's scroll down and check out some features!",
      "image": IconEnums.introFirst.iconName,
    },
    {
      "text":
          "You can use the app in dark theme, light theme and any accent color you want!",
      "image": IconEnums.introSecond.iconName,
    },
    {
      "text":
          "You can use the app in English, Turkish, German, Japanese or Arabic!\n(More language options to come.)",
      "image": IconEnums.introThird.iconName,
    },
  ];

  static const List<String> languageList = <String>[
    'Turkish',
    'English',
    'German',
    'Japanese',
    'Arabic',
  ];
}
