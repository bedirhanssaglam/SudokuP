import 'package:flutter/material.dart';
import 'package:sudoku_app/core/components/text/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/app/color_constants.dart';

class GameOverAlertDialog extends StatelessWidget {
  static bool newGame = false;
  static bool restartGame = false;

  const GameOverAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: ColorConstants.secondaryBackgroundColor,
      title: CustomText(
        AppLocalizations.of(context)!.gameOver,
        textStyle: TextStyle(color: ColorConstants.foregroundColor),
      ),
      content: Text(
        AppLocalizations.of(context)!.successfully,
        style: TextStyle(color: ColorConstants.foregroundColor),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  ColorConstants.primaryColor)),
          onPressed: () {
            Navigator.pop(context);
            restartGame = true;
          },
          child: CustomText(AppLocalizations.of(context)!.restartGame),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  ColorConstants.primaryColor)),
          onPressed: () {
            Navigator.pop(context);
            newGame = true;
          },
          child: CustomText(AppLocalizations.of(context)!.newGame),
        ),
      ],
    );
  }
}
