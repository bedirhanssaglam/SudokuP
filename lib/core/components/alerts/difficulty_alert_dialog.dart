import 'package:flutter/material.dart';
import 'package:sudoku_app/core/components/text/custom_text.dart';
import '../../constants/app/color_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DifficultyAlertDialog extends StatefulWidget {
  final String currentDifficultyLevel;

  const DifficultyAlertDialog(this.currentDifficultyLevel, {Key? key})
      : super(key: key);

  @override
  AlertDifficulty createState() => AlertDifficulty(currentDifficultyLevel);

  static String? get difficulty {
    return AlertDifficulty.difficulty;
  }

  static set difficulty(String? level) {
    AlertDifficulty.difficulty = level;
  }
}

class AlertDifficulty extends State<DifficultyAlertDialog> {
  static String? difficulty;
  static final List<String> difficulties = [
    'beginner',
    'easy',
    'medium',
    'hard'
  ];
  String currentDifficultyLevel;

  AlertDifficulty(this.currentDifficultyLevel);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: CustomText(
        AppLocalizations.of(context)!.setDifficulty,
        textStyle: TextStyle(color: ColorConstants.foregroundColor),
      )),
      backgroundColor: ColorConstants.secondaryBackgroundColor,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        for (String level in difficulties)
          SimpleDialogOption(
            onPressed: () {
              if (level != currentDifficultyLevel) {
                setState(() {
                  difficulty = level;
                });
              }
              Navigator.pop(context);
            },
            child: CustomText(
              level[0].toUpperCase() + level.substring(1),
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                  fontSize: 15,
                  color: level == currentDifficultyLevel
                      ? ColorConstants.primaryColor
                      : ColorConstants.foregroundColor),
            ),
          ),
      ],
    );
  }
}
